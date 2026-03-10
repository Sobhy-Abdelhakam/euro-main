import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'utils/interceptors.dart';

final GetIt getIt = GetIt.instance;

const _baseUrl = "https://api.euroassistance.net/";
const _timeout = Duration(minutes: 1);

void injection() {
  if (!getIt.isRegistered<Dio>()) {
    getIt
      ..registerLazySingleton<BaseOptions>(_baseOptions)
      ..registerLazySingleton<Dio>(_dio);
  }
}

BaseOptions _baseOptions() {
  return BaseOptions(
    baseUrl: _baseUrl,
    sendTimeout: _timeout,
    connectTimeout: _timeout,
    receiveTimeout: _timeout,
  );
}

Dio _dio() {
  final dio = Dio(getIt<BaseOptions>());

  dio.interceptors.addAll([
    AuthInterceptor(),
    LoggingInterceptor(),
  ]);

  return dio;
}
