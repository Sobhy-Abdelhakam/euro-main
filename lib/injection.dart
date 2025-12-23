import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'utils/interceptors.dart';

final GetIt getIt = GetIt.instance;

void injection() {
  const duration = Duration(minutes: 1);
  getIt.registerSingleton<BaseOptions>(
    BaseOptions(
      baseUrl: "https://api.euroassistance.net/",
      sendTimeout: duration,
      connectTimeout: duration,
      receiveTimeout: duration,
    ),
  );
  getIt.registerSingleton<Dio>(Dio(getIt<BaseOptions>())
    ..interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
      // AdapterInterceptor(),
    ]));
}
