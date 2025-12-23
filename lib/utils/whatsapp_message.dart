import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class WhatsAppMessage {
  static Future<void> whatsappMessage(
    String phone,
    String message,
  ) async {
    final Uri launchUri = Uri.parse(Platform.isIOS
        ? "whatsapp://wa.me/$phone/?text=$message"
        : "whatsapp://send?phone=$phone&text=$message");
    await launchUrl(launchUri);
  }
}
