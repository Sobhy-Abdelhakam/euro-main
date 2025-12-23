import 'dart:convert';
import 'dart:developer';

import 'package:euro/models/service_model.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/paths/json_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'medical_services_state.dart';

class MedicalServicesCubit extends Cubit<MedicalServicesState> {
  MedicalServicesCubit() : super(MedicalServicesInitial()) {
    getServices();
  }

  Future<void> getServices() async {
    try {
      emit(MedicalServicesLoading());
      List<ServiceModel> services = [];
      String json = await rootBundle.loadString(JsonPath.getFile(
          fileName: "servicesMedicalList_${HiveUtils.getLanguage}"));
      List servicesJson = jsonDecode(json)["services"] as List;
      for (var element in servicesJson) {
        services.add(ServiceModel.fromJson(element));
      }
      emit(MedicalServicesLoaded(services: services));
    } catch (e) {
      log("$e");
      emit(MedicalServicesError());
    }
  }
}
