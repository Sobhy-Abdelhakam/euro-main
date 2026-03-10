import 'package:euro/constants/services_type.dart';
import 'package:euro/screens/roadside_assist_services/roadside_assist_services.dart';
import 'package:euro/screens/widgets/help_service_screen.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:flutter/material.dart';

class HelpAboutRoad extends StatelessWidget {
  const HelpAboutRoad({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpServicesScreen(
      serviceType: ServicesBaseType.roadside,
      helpImage: ImagePath.getJpeg(imageName: "help_roadside"),
      aboutImage: ImagePath.getJpeg(imageName: "about_roadside"),
      aboutScreen: const RoadsideAssistServicesScreen(),
    );
  }
}