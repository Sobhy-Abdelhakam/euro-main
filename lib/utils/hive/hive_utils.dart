import 'package:euro/utils/hive/hive_boxes.dart';
import 'package:euro/utils/hive/hive_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveUtils {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxes.appConfig);
    await Hive.openBox(HiveBoxes.user);
  }

  static void confirmFirstTime() {
    Hive.box(HiveBoxes.appConfig).put(HiveKeys.isFirstTime, false);
  }


   static void deleteUser() {
    Hive.box(HiveBoxes.user).delete(HiveKeys.user);
  }
  static Future<void> setLanguage(String languageCode) async {
  await Hive.box(HiveBoxes.appConfig)
      .put(HiveKeys.language, languageCode);
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
