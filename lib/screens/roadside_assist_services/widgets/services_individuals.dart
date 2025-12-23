import 'package:euro/constants/services_type.dart';
import 'package:flutter/material.dart';

import '../../../models/service_model.dart';
import '../../widgets/base_services_screen.dart';

class ServicesIndividuals extends StatefulWidget {
  final List<ServiceModel> services;

  const ServicesIndividuals({super.key, required this.services});

  @override
  State<ServicesIndividuals> createState() => _ServicesIndividualsState();
}

class _ServicesIndividualsState extends State<ServicesIndividuals> {
  @override
  Widget build(BuildContext context) {
    return BaseServicesScreen(
      services: widget.services,
      servicesBaseType: ServicesBaseType.roadside,
      servicesType: ServicesType.services_individuals,
    );
  }
}
