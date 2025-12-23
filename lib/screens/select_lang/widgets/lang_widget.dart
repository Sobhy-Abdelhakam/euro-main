import 'package:euro/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LangWidget extends StatelessWidget {
  final String title;
  const LangWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: AppColors.red, width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
