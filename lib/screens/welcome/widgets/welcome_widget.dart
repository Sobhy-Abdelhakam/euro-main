import 'package:euro/utils/app_colors.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? subTitle;

  const WelcomeWidget(
      {super.key, required this.imagePath, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: AppColors.red, width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 200,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          if (subTitle != null)
            Text(
              subTitle!,
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
