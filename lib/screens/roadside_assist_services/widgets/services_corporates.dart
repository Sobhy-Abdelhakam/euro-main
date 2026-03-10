import 'package:euro/constants/services_type.dart';
import 'package:euro/screens/widgets/base_services_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/service_model.dart';

class ServicesCorporates extends StatelessWidget {
  final List<ServiceModel> services;

  const ServicesCorporates({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return BaseServicesScreen(
      services: services,
      servicesBaseType: ServicesBaseType.roadside,
      servicesType: ServicesType.services_corporates,
    );
  }
}
