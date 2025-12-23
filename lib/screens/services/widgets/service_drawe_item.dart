import 'package:flutter/material.dart';

class ServiceDrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onTap;

  const ServiceDrawerItem(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }
}
