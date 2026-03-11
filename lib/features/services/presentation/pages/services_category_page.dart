import 'package:euro/features/services/data/datasource/service_local_data_source.dart';
import 'package:euro/features/services/domain/entities/service.dart';
import 'package:euro/features/services/presentation/widgets/service_grid_card.dart';
import 'package:euro/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ServicesCategoryPage extends StatefulWidget {
  final String type;

  const ServicesCategoryPage({super.key, required this.type});

  @override
  State<ServicesCategoryPage> createState() => _ServicesCategoryPageState();
}

class _ServicesCategoryPageState extends State<ServicesCategoryPage> {
  final datasource = ServicesLocalDatasource();
  late Future _servicesFuture;

  @override
  void initState() {
    super.initState();
    // actual language is selected in build using context locale
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final langCode = Localizations.localeOf(context).languageCode == 'ar'
        ? 'ar'
        : 'en';

    _servicesFuture = widget.type == 'medical'
        ? datasource.getMedicalServices(langCode)
        : datasource.getRoadsideServices(langCode);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.servicesAppBarTitle)),
      body: FutureBuilder(
        future: _servicesFuture,
        builder: (context, snapshot) {
          /// Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Error
          if (snapshot.hasError) {
            return _ErrorState(
              message: l10n.servicesError,
              onRetry: () {
                setState(() {
                  _servicesFuture = widget.type == 'medical'
                      ? datasource.getMedicalServices(langCode)
                      : datasource.getRoadsideServices(langCode);
                });
              },
            );
          }

          /// No data
          if (!snapshot.hasData) {
            return const _EmptyState();
          }

          final response = snapshot.data!;

          return ListView(
            children: [
              _header(response.title, response.about),
              _section(
                title: l10n.servicesIndividualTitle,
                services: response.servicesIndividuals,
              ),
              if (response.servicesCorporates.isNotEmpty)
                _section(
                  title: l10n.servicesCorporateTitle,
                  services: response.servicesCorporates,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _header(String title, String about) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            about,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required List<Service> services,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return ServiceGridCard(service: services[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          l10n.servicesEmpty,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 40, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.commonRetryButton),
            ),
          ],
        ),
      ),
    );
  }
}
