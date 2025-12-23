part of 'roadside_assist_services_cubit.dart';

@immutable
abstract class RoadsideAssistServicesState {}

class RoadsideAssistServicesInitial extends RoadsideAssistServicesState {}

class RoadsideAssistServicesLoading extends RoadsideAssistServicesState {}

class RoadsideAssistServicesLoaded extends RoadsideAssistServicesState {
  final List<ServiceModel> servicesCorporates;
  final List<ServiceModel> servicesIndividuals;

  RoadsideAssistServicesLoaded(
      {required this.servicesCorporates, required this.servicesIndividuals});
}

class RoadsideAssistServicesError extends RoadsideAssistServicesState {}
