part of 'app_config_cubit.dart';

abstract class AppConfigState {
  Locale locale;
  AppConfigState({required this.locale});
}

class AppConfigInitial extends AppConfigState {
  AppConfigInitial({required super.locale});
}
