import 'package:euro/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getLocation(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(l10n.locationServiceDisabled);
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception(
        l10n.locationPermissionDenied,
      );
    }

    return Geolocator.getCurrentPosition();
  }
}
