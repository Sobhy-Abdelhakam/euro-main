part of 'medical_services_cubit.dart';

@immutable
abstract class MedicalServicesState {}

class MedicalServicesInitial extends MedicalServicesState {}

class MedicalServicesLoading extends MedicalServicesState {}

class MedicalServicesLoaded extends MedicalServicesState {
  final List<ServiceModel> services;
  MedicalServicesLoaded({required this.services});
}

class MedicalServicesError extends MedicalServicesState {}
