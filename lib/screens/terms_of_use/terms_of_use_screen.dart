import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_colors.dart';
import '../services/widgets/language_dialog.dart';
import 'cubit/terms_of_use_cubit.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).terms_of_use),
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
        child: BlocBuilder<TermsOfUseCubit, TermsOfUseState>(
          builder: (context, state) {
            if (state is TermsOfUseLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  state.data,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.w600),
                ),
              );
            } else if (state is TermsOfUseError) {
              return const Center(
                child: Text("No services"),
              );
            } else {
              return const Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
