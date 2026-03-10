import 'package:euro/constants/services_type.dart';
import 'package:flutter/material.dart';

import '../../../models/service_model.dart';
import '../../widgets/base_services_screen.dart';

class ServicesIndividuals extends StatelessWidget {
  final List<ServiceModel> services;

  const ServicesIndividuals({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return BaseServicesScreen(
      services: services,
      servicesBaseType: ServicesBaseType.roadside,
      servicesType: ServicesType.services_individuals,
    );
  }
}
