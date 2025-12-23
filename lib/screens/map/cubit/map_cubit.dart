import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:euro/constants/enum_to_string.dart';
import 'package:euro/constants/services_type.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/injection.dart';
import 'package:euro/models/user_model.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/log_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  late String _mobile;

  String _note = "";

  String? validateMoblie({required String mobile}) {
    if (mobile.isEmpty) {
      return S.current.emptyField(S.current.mobileNumber);
    } else {
      _mobile = mobile;
      return null;
    }
  }

  String? validateNote({required String note}) {
    _note = note;
    return null;
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    String address = "No address found.";

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      Placemark place = placemarks[0];

      address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    } catch (e, s) {
      Log.e('$e $s');
    }
    return address;
  }

  Future<void> sendHelp(
      {required LatLng latLng, required List<File> files}) async {
    emit(MapLoading());
    log("request service : ${selectedServices.valueToString()}");
    try {
      UserModel? user = HiveUtils.getUser;
      Map<String, dynamic> data = {
        "source": "Euro Club",
        //Required
        "service_type": selectedServices.valueToString(),
        //Required
        "mobile": _mobile,
        //Required
        "location_lat": latLng.latitude.toString(),
        //Required
        "location_long": latLng.longitude.toString(),
        //Required
        "current_location":
            await _getAddressFromLatLng(latLng.latitude, latLng.longitude),
        //Optional
        "name": user?.name ?? "",
        //Optional
        "second_mobile": user?.phoneNumber ?? "",
        //Optional
        // "passport_number": "ASEDSD2115855885", //Optional
        // "national_id": "15151115555555", //Optional
        "notes": _note,
        //Optional
      };
      FormData formData = FormData();

      // Add title to form data
      formData = FormData.fromMap(data);

      // Add images to form data
      for (int i = 0; i < files.length; i++) {
        File image = files[i];
        String fileName = image.path.split('/').last;

        formData.files.add(
          MapEntry(
            'images[]', // The key should match what your server expects
            await MultipartFile.fromFile(
              image.path,
              filename: fileName,
            ),
          ),
        );
      }
      Log.e(
          'fields: ${formData.fields.toString()}\n files: ${formData.files.toString()}');

      Response response = await getIt<Dio>().post(
        "sos.php",
        options: Options(contentType: "multipart/form-data"),
        data: formData,
      );

      log(response.data);

      if (response.statusCode == 201) {
        emit(MapLoaded());

        log("succeeded");
      } else {
        emit(MapError(message: S.current.failed));
        log("code != 201");
      }
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.sendTimeout ||
          dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        log("time out");
        emit(MapError(message: S.current.it_takes_a_long_time));
      } else {
        log("dio error");
        emit(MapError(message: S.current.failed));
      }
    } catch (e) {
      log("$e");
      emit(MapError(message: S.current.failed));
    }
  }
}
