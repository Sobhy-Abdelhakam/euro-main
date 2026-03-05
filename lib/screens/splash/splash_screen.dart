import 'dart:async';
import 'package:euro/screens/select_lang/select_lang.dart';
import 'package:euro/screens/welcome/welcome_screen.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(milliseconds: 3800), _navigateNext);
  }

  void _navigateNext() {
    if (!mounted) return;

    final nextScreen = HiveUtils.isFirstTime
        ? const SelectLang()
        : const WelcomeScreen();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          ImagePath.getGif(imageName: "intro"),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}