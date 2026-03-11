import 'dart:async';
import 'package:euro/utils/paths/image_path.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _rotationController;
  late AnimationController _logoController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _logoController.forward();

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;


    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  Widget _ring(double size, double opacity, double speed) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: speed).animate(_rotationController),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(opacity),
            width: 3,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFE30613),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [

            _ring(260, .15, 1),

            _ring(210, .25, -1.5),

            _ring(160, .4, 2),

            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  // "assets/logo.png",
                  ImagePath.getPng(imageName: "app_icon"),
                  width: 130,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}