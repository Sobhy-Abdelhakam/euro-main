import 'package:euro/constants/constants.dart';
import 'package:euro/constants/services_type.dart';
import 'package:euro/screens/medical_services/cubit/medical_services_cubit.dart';
import 'package:euro/screens/services/widgets/service_drawer.dart';
import 'package:euro/screens/widgets/base_services_screen.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_colors.dart';
import '../../utils/paths/image_path.dart';
import '../services/widgets/language_dialog.dart';

class MedicalServicesScreen extends StatefulWidget {
  const MedicalServicesScreen({super.key});

  @override
  State<MedicalServicesScreen> createState() => _MedicalServicesScreenState();
}


class _MedicalServicesScreenState extends State<MedicalServicesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: ServiceDrawer(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: Image.asset(
          ImagePath.getPng(imageName: "logo"),
          height: 45,
        ),
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
                  builder: (context) {
                    return const LanguageDialog();
                  });
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<MedicalServicesCubit, MedicalServicesState>(
          builder: (context, state) {
            if (state is MedicalServicesLoaded) {
              if (state.services.isNotEmpty) {
                return BaseServicesScreen(
                  services: state.services,
                  servicesBaseType: ServicesBaseType.medical,
                );
              } else {
                return const Center(
                  child: Text("No services"),
                );
              }
            } else if (state is MedicalServicesError) {
              return const Center(
                child: Text("No services"),
              );
            } else {
              return const Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
