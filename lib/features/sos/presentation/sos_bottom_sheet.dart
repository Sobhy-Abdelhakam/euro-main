import 'dart:io';

import 'package:euro/core/geocoding_service.dart';
import 'package:euro/features/sos/data/location_service.dart';
import 'package:euro/features/sos/data/sos_api_service.dart';
import 'package:euro/features/sos/presentation/image_picker_widget.dart';
import 'package:euro/features/sos/presentation/location_picker_page.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SOSBottomSheet extends StatefulWidget {
  const SOSBottomSheet({super.key});

  @override
  State<SOSBottomSheet> createState() => _SOSBottomSheetState();
}

class _SOSBottomSheetState extends State<SOSBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  String serviceType = 'Roadside';
  bool loading = false;

  Position? position;
  String? address;
  String? locationError;

  List<File> attachedImages = [];

  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  Future<void> loadLocation() async {
    try {
      final pos = await LocationService.getLocation();

      final addr = await GeocodingService.getAddress(
        latitude: pos.latitude,
        longitude: pos.longitude,
      );

      setState(() {
        position = pos;
        address = addr;
        locationError = null;
      });
    } catch (e) {
      setState(() {
        locationError = e.toString();
      });
    }
  }

  Future<void> sendSOS() async {
    if (!_formKey.currentState!.validate()) return;
    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get your location. Please try again.'),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await SosApiService().sendSOS(
        name: nameController.text.trim(),
        mobile: mobileController.text.trim(),
        serviceType: serviceType,
        lat: position!.latitude,
        long: position!.longitude,
        images: attachedImages,
      );

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOS Request Sent Successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send request: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.sos_rounded, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Request Assistance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Mobile',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a mobile number';
                    }
                    if (value.trim().length < 7) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: serviceType,
                  items: const [
                    DropdownMenuItem(
                      value: 'Roadside',
                      child: Text('Roadside Assistance'),
                    ),
                    DropdownMenuItem(
                      value: 'Medical',
                      child: Text('Medical Assistance'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      serviceType = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Service Type',
                  ),
                ),
                const SizedBox(height: 20),
                ImagePickerWidget(
                  onChanged: (files) {
                    attachedImages = files;
                  },
                ),
                const SizedBox(height: 20),
                _locationPreview(),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: loading ? null : sendSOS,
                  icon: loading
                      ? const SizedBox.shrink()
                      : const Icon(Icons.sos_rounded),
                  label: loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('SEND SOS'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _locationPreview() {
    if (position == null && locationError == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (locationError != null && position == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            locationError!,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: loadLocation,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry location'),
          ),
        ],
      );
    }

    final latLng = LatLng(
      position!.latitude,
      position!.longitude,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Location',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: latLng,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('me'),
                position: latLng,
              )
            },
            zoomControlsEnabled: false,
            myLocationEnabled: true,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                address ?? 'Loading address...',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: selectLocation,
          icon: const Icon(Icons.map),
          label: const Text('Choose another location'),
        )
      ],
    );
  }

  Future<void> selectLocation() async {
    if (position == null) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPickerPage(
          initialLocation: LatLng(
            position!.latitude,
            position!.longitude,
          ),
        ),
      ),
    );

    if (result != null) {
      final addr = await GeocodingService.getAddress(
        latitude: result.latitude,
        longitude: result.longitude,
      );

      setState(() {
        position = Position(
          longitude: result.longitude,
          latitude: result.latitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );

        address = addr;
        locationError = null;
      });
    }
  }
}
