import 'dart:io';

import 'package:euro/features/sos/data/location_service.dart';
import 'package:euro/features/sos/data/sos_api_service.dart';
import 'package:euro/features/sos/presentation/image_picker_widget.dart';
import 'package:flutter/material.dart';

class SOSPage extends StatefulWidget {
  const SOSPage({super.key});

  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  String serviceType = "Roadside";

  List<File> attachedImages = [];

  Future sendSOS() async {
    final position = await LocationService.getLocation();

    await SosApiService().sendSOS(
      name: nameController.text,
      mobile: mobileController.text,
      serviceType: serviceType,
      lat: position.latitude,
      long: position.longitude,
      images: attachedImages,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("SOS Request Sent Successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Assistance"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name",
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: mobileController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: "Mobile",
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            initialValue: serviceType,
            items: const [
              DropdownMenuItem(
                value: "Roadside",
                child: Text("Roadside Assistance"),
              ),
              DropdownMenuItem(
                value: "Medical",
                child: Text("Medical Assistance"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                serviceType = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: "Service Type",
            ),
          ),
          const SizedBox(height: 20),
          ImagePickerWidget(
            onChanged: (files) {
              attachedImages = files;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: sendSOS,
            child: const Text("Send SOS Request"),
          )
        ],
      ),
    );
  }
}
