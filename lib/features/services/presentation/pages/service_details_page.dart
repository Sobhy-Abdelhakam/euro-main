import 'package:euro/features/services/domain/entities/service.dart';
import 'package:euro/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ServiceDetailsPage extends StatelessWidget {
  final Service service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {

    final hasChildren = service.subServices.isNotEmpty;

    return Scaffold(

      appBar: AppBar(
        title: Text(service.name),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          /// Icon
          Center(
            child: ImageUtils.buildImage(service.img, size: 90),
          ),

          const SizedBox(height: 20),

          /// Title
          Text(
            service.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          /// Header
          Text(
            service.header,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          if (service.notes.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(service.notes),
            ),

          const SizedBox(height: 30),

          if (hasChildren)
            const Text(
              "Included Services",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

          const SizedBox(height: 12),

          if (hasChildren)
            ...service.subServices.map(
              (subService) => Card(
                child: ListTile(

                  leading: ImageUtils.buildImage(subService.img),

                  title: Text(subService.name),

                  trailing: const Icon(Icons.arrow_forward_ios),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailsPage(
                          service: subService,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}