import 'package:euro/features/services/presentation/pages/services_category_page.dart';
import 'package:euro/features/sos/presentation/sos_bottom_sheet.dart';
import 'package:euro/l10n/app_localizations.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ServicesHomePage extends StatelessWidget {
  const ServicesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.servicesHomeTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.red,
        icon: const Icon(Icons.emergency_rounded),
        label: Text(l10n.servicesHomeSosLabel),
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer.withOpacity(0.9),
                  colorScheme.secondaryContainer.withOpacity(0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.travel_explore_rounded,
                    color: colorScheme.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.servicesHomeHeader,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.servicesHomeDescription,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _CategoryCard(
            title: l10n.servicesHomeRoadsideTitle,
            icon: Icons.car_repair_rounded,
            type: 'roadside',
            color: Colors.blue.shade50,
          ),
          const SizedBox(height: 16),
          _CategoryCard(
            title: l10n.servicesHomeMedicalTitle,
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
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ServicesCategoryPage(type: type),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.9)),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
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
                        l10n.servicesHomeCardSubtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.67),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: colorScheme.onSurface.withOpacity(0.65),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
