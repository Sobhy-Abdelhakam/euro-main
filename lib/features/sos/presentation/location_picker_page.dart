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

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Select Location"),
      ),

      body: Stack(

        children: [

          GoogleMap(

            initialCameraPosition: CameraPosition(
              target: selectedLocation,
              zoom: 16,
            ),

            onCameraMove: (cameraPosition){
              selectedLocation = cameraPosition.target;
            },

            markers: {
              Marker(
                markerId: const MarkerId("selected"),
                position: selectedLocation,
              )
            },

          ),

          Positioned(

            bottom: 20,
            left: 20,
            right: 20,

            child: ElevatedButton(

              onPressed: (){
                Navigator.pop(context, selectedLocation);
              },

              child: const Text("Confirm Location"),

            ),

          )

        ],

      ),

    );
  }
}