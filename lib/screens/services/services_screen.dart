import 'dart:developer';

import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/screens/map/map_screen.dart';
import 'package:euro/screens/medical_services/medical_services_screen.dart';
import 'package:euro/screens/roadside_assist_services/roadside_assist_services.dart';
import 'package:euro/screens/services/widgets/service_drawer.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/utils/location_helper.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'widgets/language_dialog.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<Widget> taps = [];

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize tabs here where S.of(context) is available
    if (taps.isEmpty) {
      taps = [
        Text(S.of(context).medical_services),
        Text(S.of(context).roadside_services),
      ];
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: ServicesType.selectedIndex,
      initialIndex: 0,
      length: taps.length,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.grey,
        drawer: ServiceDrawer(scaffoldKey: scaffoldKey),
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
                setState(() {});
              },
              icon: const Icon(Icons.language),
            ),
          ],
          leading: IconButton(
            color: const Color(0xff292929),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Color(0xff292929),
            ),
          ),
          title: Image.asset(
            ImagePath.getPng(imageName: "logo"),
            height: 45,
          ),
          backgroundColor: AppColors.grey,
          // actions: [
          //   Builder(builder: (context) {
          //     return IconButton(
          //       onPressed: () {
          //         Scaffold.of(context).openDrawer();
          //       },
          //       icon: const Icon(
          //         Icons.menu,
          //         color: Color(0xff292929),
          //       ),
          //     );
          //   }),
          // ],
          bottom: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            tabs: [
              Text(S.of(context).medical_services),
              Text(S.of(context).roadside_services),
            ],
            onTap: (index) {
              // ServicesType.selectedIndex = index;
            },
          ),
        ),
        body: Column(
          children: [
            const Expanded(
              flex: 3,
              child: TabBarView(
                children: [
                  MedicalServicesScreen(),
                  RoadsideAssistServicesScreen(),
                ],
              ),
            ),
            Container(
              color: AppColors.grey,
              child: Center(
                child: InkWell(
                  onTap: () async {
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
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: AppColors.red),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          S.of(context).requestAssistance,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
