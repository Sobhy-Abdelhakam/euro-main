import 'package:euro/utils/hive/hive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(AppConfigInitial(locale: const Locale("en"))) {
    getLanguage();
  }

  void getLanguage() {
    emit(AppConfigInitial(locale: Locale(HiveUtils.getLanguage)));
  }

  void setLanguage(String languageCode) {
    emit(AppConfigInitial(locale: Locale(languageCode)));
    HiveUtils.setLanguage(languageCode);
  }
}
