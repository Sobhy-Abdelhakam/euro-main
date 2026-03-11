import 'package:euro/features/about/about_page.dart';
import 'package:euro/features/contact/page/contact_page.dart';
import 'package:euro/features/sos/presentation/sos_page.dart';
import 'package:euro/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../features/services/presentation/pages/services_home_page.dart';

import 'main_page.dart';

class AppRoutes {
  static const main = "/";
  static const splash = "/splash";
  static const services = "/services";
  static const sos = "/sos";
  static const contact = "/contact";
  static const about = "/about";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
        );
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case services:
        return MaterialPageRoute(
          builder: (_) => const ServicesHomePage(),
        );

      case sos:
        return MaterialPageRoute(
          builder: (_) => const SOSPage(),
        );

      case contact:
        return MaterialPageRoute(
          builder: (_) => const ContactPage(),
        );

      case about:
        return MaterialPageRoute(
          builder: (_) => const AboutPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
        );
    }
  }
}
