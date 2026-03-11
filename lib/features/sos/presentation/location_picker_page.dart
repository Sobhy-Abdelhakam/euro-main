import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerPage extends StatefulWidget {
  final LatLng initialLocation;

  const LocationPickerPage({
    super.key,
    required this.initialLocation,
  });

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  late LatLng selectedLocation;
  late CameraPosition cameraPosition;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
    cameraPosition = CameraPosition(target: selectedLocation, zoom: 16);
  }

  void _onCameraMove(CameraPosition position) {
    cameraPosition = position;
    setState(() {});
  }

  void _onCameraIdle() {
    setState(() {
      selectedLocation = cameraPosition.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lat = selectedLocation.latitude.toStringAsFixed(6);
    final lng = selectedLocation.longitude.toStringAsFixed(6);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                cameraPosition = CameraPosition(
                  target: widget.initialLocation,
                  zoom: 16,
                );
              });
            },
            icon: const Icon(Icons.my_location),
            tooltip: 'Reset to initial location',
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition,
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId('selected_location'),
                position: selectedLocation,
              )
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.place, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Lat: $lat · Lng: $lng',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, selectedLocation),
                      child: const Text('Confirm'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: IgnorePointer(
              ignoring: true,
              child: const Icon(
                Icons.location_on,
                size: 40,
                color: Colors.redAccent,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, selectedLocation),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Set This Location'),
            ),
          ),
        ],
      ),
    );
  }
}
