import 'dart:developer';

import 'package:euro/constants/constants.dart';
import 'package:euro/constants/services_type.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/screens/map/map_screen.dart';
import 'package:euro/utils/location_helper.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/screens/services/widgets/language_dialog.dart';
import 'package:euro/screens/welcome/widgets/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HelpServicesScreen extends StatelessWidget {
  final ServicesBaseType serviceType;
  final String helpImage;
  final String aboutImage;
  final Widget aboutScreen;

  const HelpServicesScreen({
    super.key,
    required this.serviceType,
    required this.helpImage,
    required this.aboutImage,
    required this.aboutScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        title: Image.asset(
          ImagePath.getPng(imageName: "logo"),
          height: 45,
        ),
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
                builder: (_) => const LanguageDialog(),
              );
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            /// HELP
            WelcomeWidget(
              imagePath: helpImage,
              title: S.of(context).help,
              onTap: () async {
                selectedServices = serviceType;

                try {
                  final location =
                      await LocationHelper.determinePosition();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MapScreen(
                        location: LatLng(
                          location.latitude,
                          location.longitude,
                        ),
                      ),
                    ),
                  );
                } catch (e) {
                  log("$e");
                }
              },
            ),

            const SizedBox(height: 16),

            /// ABOUT
            WelcomeWidget(
              imagePath: aboutImage,
              title: S.of(context).info,
              onTap: () {
                selectedServices = serviceType;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => aboutScreen,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}