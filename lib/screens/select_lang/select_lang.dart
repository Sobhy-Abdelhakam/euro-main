import 'package:euro/screens/app_config/app_config_cubit.dart';
import 'package:euro/screens/select_lang/widgets/lang_widget.dart';
import 'package:euro/screens/welcome/welcome_screen.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLang extends StatelessWidget {
  const SelectLang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: ListView(
              children: [
                const SizedBox(height: 20),

                Image.asset(
                  ImagePath.getPng(imageName: "logo"),
                  height: 50,
                ),
                const SizedBox(height: 60),
                _langButton(context, "العربية", "ar"),
              const SizedBox(height: 30),
              _langButton(context, "English", "en"),
              ],
            ),
          ),
      ),
    );
  }

  Widget _langButton(BuildContext context, String title, String code) {
    return GestureDetector(
      onTap: () => _selectLang(context, code),
      child: LangWidget(title: title),
    );
  }
  void _selectLang(BuildContext context, String code) {
    HiveUtils.confirmFirstTime();
    context.read<AppConfigCubit>().setLanguage(code);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }
}
