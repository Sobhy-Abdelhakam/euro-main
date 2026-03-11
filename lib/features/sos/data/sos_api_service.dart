import 'dart:io';

import 'package:dio/dio.dart';

class SosApiService {
  SosApiService()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 20),
          ),
        );

  final Dio dio;

  Future<void> sendSOS({
    required String name,
    required String mobile,
    required String serviceType,
    required double lat,
    required double long,
    required List<File> images,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'mobile': mobile,
      'service_type': serviceType,
      'location_lat': lat,
      'location_long': long,
      'images[]': images
          .map(
            (file) => MultipartFile.fromFileSync(file.path),
          )
          .toList(),
    });

    try {
      final response = await dio.post(
        'https://api.euroassistance.net/sos.php',
        data: formData,
      );

      final statusCode = response.statusCode ?? 500;
      if (statusCode < 200 || statusCode >= 300) {
        throw Exception('SOS Request Failed (code: $statusCode)');
      }
    } on DioError catch (e) {
      throw Exception(
        e.message ?? 'Network error while sending SOS request',
      );
    } catch (e) {
      rethrow;
    }
  }
}