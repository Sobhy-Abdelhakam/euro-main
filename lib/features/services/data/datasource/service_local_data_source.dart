import 'dart:convert';

import 'package:euro/utils/paths/json_path.dart';
import 'package:flutter/services.dart';

import '../models/services_response_model.dart';

class ServicesLocalDatasource {
  static final Map<String, ServicesResponseModel> _cache = {};

  Future<ServicesResponseModel> getRoadsideServices(String lang) async {
    final cacheKey = 'roadside_$lang';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final file = lang == 'ar'
          ? JsonPath.getFile(fileName: 'servicesList_ar')
          : JsonPath.getFile(fileName: 'servicesList_en');

      final jsonString = await rootBundle.loadString(file);
      final data = json.decode(jsonString) as Map<String, dynamic>;

      final model = ServicesResponseModel.fromJson(data);
      _cache[cacheKey] = model;
      return model;
    } catch (e) {
      throw Exception('Failed to load roadside services: $e');
    }
  }

  Future<ServicesResponseModel> getMedicalServices(String lang) async {
    final cacheKey = 'medical_$lang';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final file = lang == 'ar'
          ? JsonPath.getFile(fileName: 'servicesMedicalList_ar')
          : JsonPath.getFile(fileName: 'servicesMedicalList_en');

      final jsonString = await rootBundle.loadString(file);
      final data = json.decode(jsonString) as Map<String, dynamic>;

      final model = ServicesResponseModel.fromJson(data);
      _cache[cacheKey] = model;
      return model;
    } catch (e) {
      throw Exception('Failed to load medical services: $e');
    }
  }
}
