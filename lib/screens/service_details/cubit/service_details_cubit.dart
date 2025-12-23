import 'dart:convert';
import 'dart:developer';

import 'package:euro/constants/enum_to_string.dart';
import 'package:euro/constants/services_type.dart';
import 'package:euro/models/service_model.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/paths/json_path.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(ServiceDetailsInitial());

  Future<void> getServices() async {
    try {
      emit(ServiceDetailsLoading());
      if (selectedServices == ServicesBaseType.roadside) {
        List<ServiceModel> services = [];
        String json = await rootBundle.loadString(JsonPath.getFile(
            fileName: "servicesList_${HiveUtils.getLanguage}"));
        List servicesJson = jsonDecode(json)[servicesType.valueToString()] as List;
        for (var element in servicesJson) {
          services.add(ServiceModel.fromJson(element));
        }
        emit(ServiceDetailsLoaded(services: services));
      } else {
        List<ServiceModel> services = [];
        String json = await rootBundle.loadString(JsonPath.getFile(
            fileName: "servicesMedicalList_${HiveUtils.getLanguage}"));
        List servicesJson = jsonDecode(json)["services"] as List;
        for (var element in servicesJson) {
          services.add(ServiceModel.fromJson(element));
        }
        emit(ServiceDetailsLoaded(services: services));
      }
    } catch (e) {
      log("$e");
      emit(ServiceDetailsError());
    }
  }
}
