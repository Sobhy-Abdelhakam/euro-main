import 'package:auto_size_text/auto_size_text.dart';
import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/utils.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import '../../utils/app_colors.dart';
import '../services/widgets/language_dialog.dart';
import 'cubit/about_us_cubit.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(S.of(context).aboutUs),
        backgroundColor: AppColors.grey,
        actions: [
          IconButton(
            onPressed: () {
              WhatsAppMessage.whatsappMessage(roadsideWhatsApp, '');
            },
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const LanguageDialog();
                  });
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            opacity: 0.5,
            image: AssetImage(
              ImagePath.getPng(imageName: 'logo'),
            ),
          ),
        ),
        child: BlocBuilder<AboutUsCubit, AboutUsState>(
          builder: (context, state) {
            if (state is AboutUsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    AutoSizeText(
                      state.data,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.w600),
                    ),
                    Align(
                      alignment: intl.Intl.getCurrentLocale() == 'en'
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AutoSizeText(
                                  '${S.of(context).website} :',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: InkWell(
                                    onTap: () {
                                      Utils.launchInWebViewWithoutJavaScript(
                                          website);
                                    },
                                    child: const AutoSizeText(
                                      website,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 21,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  '${S.of(context).landLine} :',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: InkWell(
                                    onTap: () {
                                      Utils.makePhoneCall(landLine);
                                    },
                                    child: const AutoSizeText(
                                      landLine,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 21,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    '${S.of(context).roadside} ${S.of(context).whatsApp} :',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: InkWell(
                                    onTap: () {
                                      Utils.makePhoneCall(roadsideWhatsApp);
                                    },
                                    child: const AutoSizeText(
                                      roadsideWhatsApp,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 21,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    '${S.of(context).roadside} ${S.of(context).email} :',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: InkWell(
                                    onTap: () {
                                      Utils.emailTo(roadsideEmail);
                                    },
                                    child: const AutoSizeText(
                                      roadsideEmail,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 21,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    '${S.of(context).medical_services} ${S.of(context).whatsApp} :',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: InkWell(
                                    onTap: () {
                                      Utils.makePhoneCall(medicalWhatsApp);
                                    },
                                    child: const AutoSizeText(
                                      medicalWhatsApp,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 21,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    '${S.of(context).medical_services} ${S.of(context).email} :',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: InkWell(
                                    onTap: () {
                                      Utils.emailTo(medicalEmail);
                                    },
                                    child: const AutoSizeText(
                                      roadsideEmail,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 21,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AutoSizeText(S.of(context).copyright,maxLines: 1,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is AboutUsError) {
              return const Center(
                child: AutoSizeText("No services"),
              );
            } else {
              return const AutoSizeText("Loading...");
            }
          },
        ),
      ),
    );
  }
}
