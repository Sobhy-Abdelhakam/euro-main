import 'dart:convert';
import 'dart:developer';

import 'package:euro/models/service_model.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/paths/json_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'roadside_assist_services_state.dart';

class RoadsideAssistServicesCubit extends Cubit<RoadsideAssistServicesState> {
  RoadsideAssistServicesCubit() : super(RoadsideAssistServicesInitial()) {
    getServices();
  }

  Future<void> getServices() async {
    try {
      emit(RoadsideAssistServicesLoading());
      List<ServiceModel> servicesCorporates = [];
      List<ServiceModel> servicesIndividuals = [];
      String json = await rootBundle.loadString(
          JsonPath.getFile(fileName: "servicesList_${HiveUtils.getLanguage}"));
      List servicesIndividualsJson =
          jsonDecode(json)["services_individuals"] as List;
      List servicesCorporatesJson =
          jsonDecode(json)["services_corporates"] as List;
      for (var element in servicesIndividualsJson) {
        servicesIndividuals.add(ServiceModel.fromJson(element));
      }
      for (var element in servicesCorporatesJson) {
        servicesCorporates.add(ServiceModel.fromJson(element));
      }
      emit(RoadsideAssistServicesLoaded(
        servicesCorporates: servicesCorporates,
        servicesIndividuals: servicesIndividuals,
      ));
    } catch (e) {
      log("$e");
      emit(RoadsideAssistServicesError());
    }
  }
}
