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
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
          elevation: 0,
          backgroundColor: AppColors.grey,
          leading: null,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(seconds: 1),
              child: FadeInAnimation(
                child: ScaleAnimation(
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          S.of(context).welcome,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Image.asset(
                        ImagePath.getPng(imageName: "logo"),
                        height: 50,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HelpAboutRoad()));
                        },
                        child: WelcomeWidget(
                          imagePath:
                              ImagePath.getPng(imageName: "roadside_services"),
                          title: S.of(context).roadside_services,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HelpAboutMedical()));
                        },
                        child: WelcomeWidget(
                          imagePath:
                              ImagePath.getPng(imageName: "medical_services"),
                          title: S.of(context).medical_services,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          WhatsAppMessage.whatsappMessage(roadsideWhatsApp, '');
                        },
                        child: WelcomeWidget(
                          imagePath: ImagePath.getPng(imageName: "ic_whatsapp"),
                          title: S.of(context).whatsAppContact,
                          subTitle: roadsideWhatsApp,
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
