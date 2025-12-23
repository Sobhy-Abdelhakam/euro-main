import 'dart:convert';

import 'package:euro/models/user_model.dart';
import 'package:euro/utils/hive/hive_boxes.dart';
import 'package:euro/utils/hive/hive_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveUtils {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxes.appConfig);
    await Hive.openBox(HiveBoxes.user);
  }

  static void saveUser(UserModel user) {
    Hive.box(HiveBoxes.user).put(HiveKeys.user, jsonEncode(user.toMap));
  }

  static void confirmFirstTime() {
    Hive.box(HiveBoxes.appConfig).put(HiveKeys.isFirstTime, false);
  }


  static UserModel? get getUser {
    String? json =
        Hive.box(HiveBoxes.user).get(HiveKeys.user, defaultValue: null);
    if (json != null) {
      return UserModel.fromJson(jsonDecode(json));
    } else {
      return null;
    }
  }

  static void deleteUser() {
    Hive.box(HiveBoxes.user).delete(HiveKeys.user);
  }

  static void setLanguage(String languageCode) async {
     Hive.box(HiveBoxes.appConfig).put(HiveKeys.language, languageCode);
  }

  static String get getLanguage {
    return Hive.box(HiveBoxes.appConfig)
        .get(HiveKeys.language, defaultValue: "ar");
  }

  static bool get isFirstTime {
    return Hive.box(HiveBoxes.appConfig)
        .get(HiveKeys.isFirstTime, defaultValue: true);
  }
}
