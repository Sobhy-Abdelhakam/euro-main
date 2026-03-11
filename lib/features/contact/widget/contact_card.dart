import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(

        leading: CircleAvatar(
          child: Icon(icon),
        ),

        title: Text(title),

        subtitle: Text(subtitle),

        trailing: const Icon(Icons.arrow_forward_ios),

        onTap: onTap,

      ),

    );
  }
}