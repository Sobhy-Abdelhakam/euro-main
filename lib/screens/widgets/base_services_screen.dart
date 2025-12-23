import 'dart:developer';

import 'package:euro/constants/services_type.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/models/service_model.dart';
import 'package:euro/screens/map/map_screen.dart';
import 'package:euro/screens/service_details/service_details_screen.dart';
import 'package:euro/screens/widgets/service_item.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../service_details/cubit/service_details_cubit.dart';

class BaseServicesScreen extends StatefulWidget {
  final List<ServiceModel> services;
  final ServicesBaseType servicesBaseType;

  final ServicesType servicesType;

  const BaseServicesScreen({
    super.key,
    required this.services,
    required this.servicesBaseType,
    this.servicesType = ServicesType.services_corporates,
  });

  @override
  State<BaseServicesScreen> createState() => _BaseServicesScreenState();
}

class _BaseServicesScreenState extends State<BaseServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: AnimationLimiter(
                child: AlignedGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  // padding: const EdgeInsets.all(5),
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  itemCount: widget.services.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(seconds: 1),
                      child: SlideAnimation(
                        verticalOffset: 100.0,
                        child: ScaleAnimation(
                          child: InkWell(
                            onTap: () {
                              servicesType = widget.servicesType;
                              BlocProvider.of<ServiceDetailsCubit>(context)
                                  .getServices();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceDetailsScreen(
                                    subServiceIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: ServiceItem(
                              data: widget.services[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              color: AppColors.grey,
              child: Center(
                child: InkWell(
                  onTap: () async {
                    selectedServices = widget.servicesBaseType;
                    try {
                      await LocationHelper.determinePosition()
                          .then((location) => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MapScreen(
                                      location: LatLng(location.latitude,
                                          location.longitude),
                                    ),
                                  ),
                                )
                              });
                    } catch (e) {
                      log("$e");
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: AppColors.red),
                    child: Center(
                      child: Text(
                        S.of(context).requestAssistance,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
