import 'dart:io';

import 'package:euro/core/geocoding_service.dart';
import 'package:euro/features/sos/data/location_service.dart';
import 'package:euro/features/sos/data/sos_api_service.dart';
import 'package:euro/features/sos/presentation/image_picker_widget.dart';
import 'package:euro/features/sos/presentation/location_picker_page.dart';
import 'package:euro/l10n/app_localizations.dart';
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
    // Delay location loading until after first frame so inherited widgets
    // (like Localizations) are fully available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        loadLocation();
      }
    });
  }

  Future<void> loadLocation() async {
    try {
      final pos = await LocationService.getLocation(context);

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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.sosSheetLocationSnackbar),
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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.sosSheetSuccess),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.sosSheetFailure(e)),
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
    final l10n = AppLocalizations.of(context)!;
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
                  children: [
                    const Icon(Icons.sos_rounded, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      l10n.sosSheetTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.sosTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.sosDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black.withOpacity(0.7),
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.sosSheetNameLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: l10n.sosSheetNameLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.sosSheetNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.sosSheetMobileLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: l10n.sosSheetMobileLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.sosSheetMobileRequired;
                    }
                    if (value.trim().length < 7) {
                      return l10n.sosSheetMobileInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.sosSheetServiceTypeLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: serviceType,
                  items: [
                    DropdownMenuItem(
                      value: 'Roadside',
                      child: Text(l10n.sosSheetServiceTypeRoadside),
                    ),
                    DropdownMenuItem(
                      value: 'Medical',
                      child: Text(l10n.sosSheetServiceTypeMedical),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      serviceType = value;
                    });
                  },
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  color: Colors.grey.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ImagePickerWidget(
                      onChanged: (files) {
                        attachedImages = files;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _locationPreview(),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: Colors.white,
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
                      : Text(l10n.sosSheetSendButton),
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
      final l10n = AppLocalizations.of(context)!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.sosSheetLocationTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
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
            label: Text(l10n.sosSheetLocationRetry),
          ),
        ],
      );
    }

    final latLng = LatLng(
      position!.latitude,
      position!.longitude,
    );

    final l10n = AppLocalizations.of(context)!;
    final latText = position!.latitude.toStringAsFixed(6);
    final lngText = position!.longitude.toStringAsFixed(6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sosSheetYourLocation,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 220,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              GoogleMap(
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
                myLocationButtonEnabled: false,
                onTap: (_) => selectLocation(),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: selectLocation,
                    splashColor: Colors.white.withOpacity(0.2),
                    highlightColor: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.location_on,
                  size: 36,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.place, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Coordinates: $latText, $lngText',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                address ?? l10n.sosSheetLoadingAddress,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: selectLocation,
          icon: const Icon(Icons.map),
          label: Text(l10n.sosSheetChooseAnotherLocation),
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
