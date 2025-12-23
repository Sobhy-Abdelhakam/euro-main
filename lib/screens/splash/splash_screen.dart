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
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(milliseconds: 3800),
      () {
        if(HiveUtils.isFirstTime){
Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const SelectLang()));
        }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Image.asset(ImagePath.getGif(imageName: "intro"),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
