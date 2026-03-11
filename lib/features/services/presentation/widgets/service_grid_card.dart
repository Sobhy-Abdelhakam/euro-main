import 'package:euro/features/services/domain/entities/service.dart';
import 'package:euro/features/services/presentation/pages/service_details_page.dart';
import 'package:euro/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ServiceGridCard extends StatelessWidget {
  final Service service;

  const ServiceGridCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(16),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailsPage(service: service),
          ),
        );
      },

      child: Card(

        elevation: 3,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        child: Padding(

          padding: const EdgeInsets.all(12),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              ImageUtils.buildImage(service.img, size: 48),

              const SizedBox(height: 12),

              Text(
                service.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}