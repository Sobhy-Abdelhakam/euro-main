import 'package:euro/features/services/domain/entities/service.dart';
import 'package:euro/features/services/presentation/pages/service_details_page.dart';
import 'package:euro/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {

  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      child: ListTile(

        leading: ImageUtils.buildImage(service.img),

        title: Text(service.name),

        subtitle: Text(
          service.header,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        trailing: service.subServices.isEmpty
    ? const Icon(Icons.info_outline)
    : const Icon(Icons.arrow_forward_ios),

        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ServiceDetailsPage(service: service),
            ),
          );
        },

      ),

    );
  }
}