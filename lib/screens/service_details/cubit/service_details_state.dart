part of 'service_details_cubit.dart';

abstract class ServiceDetailsState  {

}

class ServiceDetailsInitial extends ServiceDetailsState {}

class ServiceDetailsLoading extends ServiceDetailsState {}

class ServiceDetailsLoaded extends ServiceDetailsState {
  final List<ServiceModel> services;
  ServiceDetailsLoaded({required this.services});
}

class ServiceDetailsError extends ServiceDetailsState {}
