import 'package:euro/constants/services_type.dart';
import 'package:euro/screens/medical_services/medical_services_screen.dart';
import 'package:euro/screens/widgets/help_service_screen.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:flutter/material.dart';

class HelpAboutMedical extends StatelessWidget {
  const HelpAboutMedical({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpServicesScreen(
      serviceType: ServicesBaseType.medical,
      helpImage: ImagePath.getJpeg(imageName: "help_medical"),
      aboutImage: ImagePath.getJpeg(imageName: "about_medical"),
      aboutScreen: const MedicalServicesScreen(),
    );
  }
}
