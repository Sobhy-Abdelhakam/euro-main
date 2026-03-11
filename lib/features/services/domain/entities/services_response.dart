import 'package:euro/features/services/domain/entities/service.dart';

class ServicesResponse {

  final String title;
  final String about;

  final List<Service> servicesIndividuals;
  final List<Service> servicesCorporates;

  ServicesResponse({
    required this.title,
    required this.about,
    required this.servicesIndividuals,
    required this.servicesCorporates,
  });

}