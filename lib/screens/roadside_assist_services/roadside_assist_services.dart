import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/screens/roadside_assist_services/widgets/services_individuals.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_colors.dart';
import '../../utils/paths/image_path.dart';
import '../services/widgets/language_dialog.dart';
import '../services/widgets/service_drawer.dart';
import 'cubit/roadside_assist_services_cubit.dart';

class RoadsideAssistServicesScreen extends StatefulWidget {
  const RoadsideAssistServicesScreen({super.key});

  @override
  State<RoadsideAssistServicesScreen> createState() =>
      _RoadsideAssistServicesScreenState();
}

class _RoadsideAssistServicesScreenState
    extends State<RoadsideAssistServicesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(key:scaffoldKey ,
        drawer: ServiceDrawer(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.red,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            tabs: [
              // Tab(
              //   text: S.of(context).corporates,
              // ),
              Tab(
                text: S.of(context).individuals,
              )
            ],
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<RoadsideAssistServicesCubit,
              RoadsideAssistServicesState>(
            builder: (context, state) {
              if (state is RoadsideAssistServicesLoaded) {
                return TabBarView(
                  children: [
                    ServicesIndividuals(
                      services: state.servicesIndividuals,
                    ),
                  ],
                );
              } else if (state is RoadsideAssistServicesError) {
                return const Center(
                  child: Text("No services"),
                );
              } else {
                return const Text("Loading...");
              }
            },
          ),
        ),
      ),
    );
  }
}
