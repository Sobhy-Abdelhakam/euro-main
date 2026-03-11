import 'package:euro/constants/constants.dart' as AppConstants;
import 'package:euro/features/contact/widget/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Get in touch',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Reach Euro Assist anytime for medical or roadside emergencies.',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          ContactCard(
            icon: Icons.chat,
            title: 'WhatsApp (Medical)',
            subtitle: AppConstants.medicalWhatsApp,
            onTap: () => _openWhatsApp(context, AppConstants.medicalWhatsApp),
          ),
          ContactCard(
            icon: Icons.chat,
            title: 'WhatsApp (Roadside)',
            subtitle: AppConstants.roadsideWhatsApp,
            onTap: () => _openWhatsApp(context, AppConstants.roadsideWhatsApp),
          ),
          ContactCard(
            icon: Icons.email,
            title: 'Email (Medical)',
            subtitle: AppConstants.medicalEmail,
            onTap: () => _openEmail(context, AppConstants.medicalEmail),
          ),
          ContactCard(
            icon: Icons.email,
            title: 'Email (Roadside)',
            subtitle: AppConstants.roadsideEmail,
            onTap: () => _openEmail(context, AppConstants.roadsideEmail),
          ),
          ContactCard(
            icon: Icons.phone,
            title: 'Landline',
            subtitle: AppConstants.landLine,
            onTap: () => _callPhone(context, AppConstants.landLine),
          ),
          ContactCard(
            icon: Icons.public,
            title: 'Website',
            subtitle: AppConstants.website,
            onTap: () => _openWebsite(context, AppConstants.website),
          ),
        ],
      ),
    );
  }

  Future<void> _openWhatsApp(BuildContext context, String phone) async {
    final normalizedPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final nativeUri = Uri.parse('whatsapp://send?phone=$normalizedPhone');
    final webUri = Uri.parse('https://wa.me/$normalizedPhone');

    if (await launchUrl(nativeUri, mode: LaunchMode.externalApplication)) {
      return;
    }

    if (await launchUrl(webUri, mode: LaunchMode.externalApplication)) {
      return;
    }

    _showError(context,
        'Could not open WhatsApp. Please install WhatsApp or open from browser.');
  }

  Future<void> _openEmail(BuildContext context, String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }
    _showError(context, 'No email client installed.');
  }

  Future<void> _callPhone(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }
    _showError(context, 'Phone call is unavailable.');
  }

  Future<void> _openWebsite(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }
    if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      return;
    }
    _showError(context, 'Could not open website.');
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
