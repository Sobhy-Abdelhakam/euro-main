import 'package:euro/constants/services_type.dart';
import 'package:euro/screens/widgets/base_services_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/service_model.dart';

class ServicesCorporates extends StatefulWidget {
  final List<ServiceModel> services;

  const ServicesCorporates({super.key, required this.services});

  @override
  State<ServicesCorporates> createState() => _ServicesCorporatesState();
}

class _ServicesCorporatesState extends State<ServicesCorporates> {
  @override
  Widget build(BuildContext context) {
    return BaseServicesScreen(
      services: widget.services,
      servicesBaseType: ServicesBaseType.roadside,
      servicesType: ServicesType.services_corporates,
    );
  }
}
