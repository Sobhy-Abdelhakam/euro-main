import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppMessage {
  static Future<void> whatsappMessage(
    String phone,
    String message,
  ) async {
    try {
      final Uri launchUri = Uri.parse(Platform.isIOS
          ? "whatsapp://wa.me/$phone/?text=${Uri.encodeComponent(message)}"
          : "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}");
      
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(
          launchUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Fallback to web WhatsApp if app is not installed
        final webUri = Uri.parse("https://wa.me/$phone/?text=${Uri.encodeComponent(message)}");
        if (await canLaunchUrl(webUri)) {
          await launchUrl(
            webUri,
            mode: LaunchMode.externalApplication,
          );
        } else {
          debugPrint('Could not launch WhatsApp');
        }
      }
    } catch (e) {
      debugPrint('Failed to launch WhatsApp: $e');
    }
  }
}
