import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable GPS.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception(
        'Location permission denied. Please enable it from system settings.',
      );
    }

    return Geolocator.getCurrentPosition();
  }
}
