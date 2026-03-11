import 'package:geocoding/geocoding.dart';

class GeocodingService {

  static Future<String> getAddress({
    required double latitude,
    required double longitude,
  }) async {

    try {

      final placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      final place = placemarks.first;

      final address = [
        place.street,
        place.subLocality,
        place.locality,
        place.country,
      ]
          .where((e) => e != null && e.isNotEmpty)
          .join(", ");

      return address;

    } catch (e) {
      return "Unknown location";
    }
  }
}