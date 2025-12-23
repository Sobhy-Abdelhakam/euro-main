import 'dart:convert';
import 'dart:developer';

import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/paths/json_path.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/service_model.dart';

part 'sub_services_state.dart';

class SubServicesCubit extends Cubit<SubServicesState> {
  SubServicesCubit() : super(SubServicesInitial());
  Future<void> getServices() async {
    try {
      emit(SubServicesLoading());

      List<ServiceModel> services = [];
      String json = await rootBundle.loadString(
          JsonPath.getFile(fileName: "servicesList_${HiveUtils.getLanguage}"));
      List servicesJson = jsonDecode(json)["services_individuals"] as List;
      var x = servicesJson.last["serviceList"];
      for (var element in x) {
        services.add(ServiceModel.fromJson(element));
      }
      log(services.toList().toString());
      emit(SubServicesLoaded(services: services));
    } catch (e) {
      log("$e");
      emit(SubServicesError());
    }
  }
}
