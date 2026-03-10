import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/screens/help_about_medical/help_about_medical.dart';
import 'package:euro/screens/help_about_road/help_about_road.dart';
import 'package:euro/screens/services/widgets/language_dialog.dart';
import 'package:euro/screens/welcome/widgets/welcome_widget.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.grey,
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
        child: Column(
          children: [
            /// Header
            Column(
              children: [
                Text(
                  S.of(context).welcome,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Image.asset(
                  ImagePath.getPng(imageName: "logo"),
                  height: 70,
                ),
              ],
            ),

            const SizedBox(height: 40),

            /// Services
            Expanded(
              child: ListView(
                children: [
                  WelcomeWidget(
                    imagePath: ImagePath.getPng(imageName: "roadside_services"),
                    title: S.of(context).roadside_services,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpAboutRoad(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  WelcomeWidget(
                    imagePath: ImagePath.getPng(imageName: "medical_services"),
                    title: S.of(context).medical_services,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpAboutMedical(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  WelcomeWidget(
                    imagePath: ImagePath.getPng(imageName: "ic_whatsapp"),
                    title: S.of(context).whatsAppContact,
                    subTitle: roadsideWhatsApp,
                    onTap: () {
                      WhatsAppMessage.whatsappMessage(
                        roadsideWhatsApp,
                        '',
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
