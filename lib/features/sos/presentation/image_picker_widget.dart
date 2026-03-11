import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<List<File>> onChanged;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker picker = ImagePicker();

  List<XFile> images = [];

  Future<void> pickImage() async {
    final result = await picker.pickMultiImage();

    if (result.isNotEmpty) {
      setState(() {
        images = result;
      });
      widget.onChanged(result.map((e) => File(e.path)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attach Images (optional)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (images.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: images.map((image) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(image.path),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        if (images.isNotEmpty) const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.photo),
          label: const Text('Add Images'),
        )
      ],
    );
  }
}
