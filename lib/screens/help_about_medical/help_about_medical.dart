import 'dart:developer';

import 'package:euro/constants/constants.dart';
import 'package:euro/constants/services_type.dart';
import 'package:euro/screens/medical_services/medical_services_screen.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../generated/l10n.dart';
import '../../utils/app_colors.dart';
import '../../utils/location_helper.dart';
import '../../utils/paths/image_path.dart';
import '../map/map_screen.dart';
import '../services/widgets/language_dialog.dart';
import '../welcome/widgets/welcome_widget.dart';

class HelpAboutMedical extends StatefulWidget {
  const HelpAboutMedical({super.key});

  @override
  State<HelpAboutMedical> createState() => _HelpAboutMedicalState();
}

class _HelpAboutMedicalState extends State<HelpAboutMedical> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Image.asset(
            ImagePath.getPng(imageName: "logo"),
            height: 45,
          ),
          backgroundColor: AppColors.grey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(seconds: 1),
              child: FadeInAnimation(
                child: ScaleAnimation(
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () async {
                          selectedServices = ServicesBaseType.medical;
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
                        child: WelcomeWidget(
                          imagePath:
                              ImagePath.getJpeg(imageName: "help_medical"),
                          title: S.of(context).help,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          selectedServices = ServicesBaseType.medical;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const MedicalServicesScreen()));
                        },
                        child: WelcomeWidget(
                          imagePath:
                              ImagePath.getJpeg(imageName: "about_medical"),
                          title: S.of(context).info,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
