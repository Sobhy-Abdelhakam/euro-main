import '../../domain/entities/services_response.dart';
import 'service_model.dart';

class ServicesResponseModel extends ServicesResponse {

  ServicesResponseModel({
    required super.title,
    required super.about,
    required super.servicesIndividuals,
    required super.servicesCorporates,
  });

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) {

  final individuals = (json["services_individuals"] as List?)
          ?.map((e) => ServiceModel.fromJson(e))
          .toList() ??
      [];

  final corporates = (json["services_corporates"] as List?)
          ?.map((e) => ServiceModel.fromJson(e))
          .toList() ??
      [];

  final services = (json["services"] as List?)
          ?.map((e) => ServiceModel.fromJson(e))
          .toList() ??
      [];

  return ServicesResponseModel(
    title: json["title"] ?? "",
    about: json["about"] ?? "",

    /// if roadside list empty use medical services
    servicesIndividuals: individuals.isNotEmpty ? individuals : services,

    servicesCorporates: corporates,
  );
}

}