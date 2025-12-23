import 'package:euro/constants/constants.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phlox_animations/phlox_animations.dart';

import '../service_details/service_details_screen.dart';
import '../services/widgets/language_dialog.dart';
import 'cubit/sub_services_cubit.dart';

class SubServicesScreen extends StatefulWidget {
  final int subServiceIndex;

  const SubServicesScreen({
    super.key,
    required this.subServiceIndex,
  });

  @override
  State<SubServicesScreen> createState() => _SubServicesScreenState();
}

class _SubServicesScreenState extends State<SubServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubServicesCubit, SubServicesState>(
      builder: (context, state) {
        if (state is SubServicesLoaded) {
          if (state.services.isNotEmpty) {
            var data = state.services[widget.subServiceIndex];
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      WhatsAppMessage.whatsappMessage(roadsideWhatsApp, '');
                    },
                    icon: const Icon(Icons.call),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const LanguageDialog();
                          });
                    },
                    icon: const Icon(Icons.language),
                  ),
                ],
                title: Image.asset(
                  ImagePath.getPng(imageName: "logo"),
                  height: 45,
                ),
                backgroundColor: AppColors.grey,
                bottom: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 40),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      color: Colors.white,
                      child: Text(
                        data.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffe01e26),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        data.header ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      PhloxAnimations(
                        duration: const Duration(seconds: 2),
                        fromScale: 0,
                        toScale: 1,
                        fromOpacity: 0,
                        toOpacity: 1,
                        child: getImage(data.img!),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  )),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text("No services"),
              ),
            );
          }
        } else if (state is SubServicesError) {
          return const Scaffold(
            body: Center(
              child: Text("No services"),
            ),
          );
        } else {
          return const Scaffold(body: Center(child: Text("Loading...")));
        }
      },
    );
  }
}
