part of 'sub_services_cubit.dart';

abstract class SubServicesState {}

class SubServicesInitial extends SubServicesState {}

class SubServicesLoading extends SubServicesState {}

class SubServicesLoaded extends SubServicesState {
  final List<ServiceModel> services;
  SubServicesLoaded({required this.services});
}

class SubServicesError extends SubServicesState {}
