import 'package:euro/features/services/data/datasource/service_local_data_source.dart';
import 'package:euro/features/services/domain/entities/service.dart';
import 'package:euro/features/services/presentation/widgets/service_grid_card.dart';
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
    _servicesFuture = widget.type == 'medical'
        ? datasource.getMedicalServices('en')
        : datasource.getRoadsideServices('en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
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
              message: 'Unable to load services. Please try again.',
              onRetry: () {
                setState(() {
                  _servicesFuture = widget.type == 'medical'
                      ? datasource.getMedicalServices('en')
                      : datasource.getRoadsideServices('en');
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
                title: 'Individual Services',
                services: response.servicesIndividuals,
              ),
              if (response.servicesCorporates.isNotEmpty)
                _section(
                  title: 'Corporate Services',
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
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No services available at the moment. Please check back later.',
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
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
