import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';

import '../services/widgets/language_dialog.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                WhatsAppMessage.whatsappMessage(roadsideWhatsApp, '');
              },
              icon: const Icon(Icons.call),
            ),
            IconButton(onPressed: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return const LanguageDialog();
                  });setState((){});
            }, icon: const Icon(Icons.language),),
          ],
        title: Image.asset(
          ImagePath.getPng(imageName: "logo"),
          height: 45,
        ),
        backgroundColor: AppColors.grey,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
          child: Container(
              height: 40,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Text(
                  S.of(context).contactUs,
                  style: const TextStyle(
                    color: Color(0xffe01e26),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: S.of(context).mobileNumber,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: S.of(context).typeMessage,
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: double.infinity,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: AppColors.red),
              child: Center(
                child: Text(
                  S.of(context).send,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
