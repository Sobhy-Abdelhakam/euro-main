import 'package:euro/features/services/presentation/pages/services_category_page.dart';
import 'package:euro/features/sos/presentation/sos_bottom_sheet.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ServicesHomePage extends StatelessWidget {
  const ServicesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.red,
        icon: const Icon(Icons.emergency_rounded),
        label: const Text('SOS'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const SOSBottomSheet(),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Choose the type of assistance',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse the full list of Euro Assist services for roadside and medical support.',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          _CategoryCard(
            title: 'Roadside Assistance',
            icon: Icons.car_repair_rounded,
            type: 'roadside',
            color: Colors.blue.shade50,
          ),
          const SizedBox(height: 16),
          _CategoryCard(
            title: 'Medical Assistance',
            icon: Icons.local_hospital_rounded,
            type: 'medical',
            color: Colors.green.shade50,
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.type,
    required this.color,
  });

  final String title;
  final IconData icon;
  final String type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServicesCategoryPage(type: type),
          ),
        );
      },
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  size: 30,
                  color: AppColors.red,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Coverage, benefits, and detailed service list.',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.black.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
