import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart' show Geolocator, LocationPermission, Position;
import 'package:location/location.dart';

/// Custom exception for location-related errors
class LocationException implements Exception {
  final String message;
  final bool canRetry;
  
  LocationException(this.message, {this.canRetry = true});
  
  @override
  String toString() => message;
}

class LocationHelper {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    try {
      serviceEnabled = await Location().requestService();
    } catch (e) {
      debugPrint('Location service request failed: $e');
      serviceEnabled = false;
    }
    
    if (!serviceEnabled) {
      throw LocationException(
        'Location services are disabled.',
        canRetry: true,
      );
    }

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      debugPrint('Geolocator service check failed: $e');
      throw LocationException(
        'Failed to check location services.',
        canRetry: true,
      );
    }
    
    if (!serviceEnabled) {
      throw LocationException(
        'Location services are disabled.',
        canRetry: true,
      );
    }

    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationException(
            'Location permissions are denied.',
            canRetry: true,
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationException(
          'Location permissions are permanently denied. Please enable them in settings.',
          canRetry: false,
        );
      }
    } catch (e) {
      if (e is LocationException) rethrow;
      debugPrint('Permission check failed: $e');
      throw LocationException(
        'Failed to check location permissions.',
        canRetry: true,
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high,
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw LocationException(
            'Location request timed out. Please try again.',
            canRetry: true,
          );
        },
      );
    } catch (e) {
      if (e is LocationException) rethrow;
      debugPrint('Failed to get current position: $e');
      throw LocationException(
        'Failed to get your location. Please try again.',
        canRetry: true,
      );
    }
  }
}
