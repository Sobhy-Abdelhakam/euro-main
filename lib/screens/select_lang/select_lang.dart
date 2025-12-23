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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 8,
              ),
              Image.asset(
                ImagePath.getPng(imageName: "logo"),
                height: 50,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  selectLang("ar", context);
                },
                child: const LangWidget(
                  title: "العربيه",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  selectLang("en", context);
                },
                child: const LangWidget(
                  title: "English",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectLang(String languageCode, BuildContext context) {
    BlocProvider.of<AppConfigCubit>(context).setLanguage(languageCode);
    HiveUtils.confirmFirstTime();
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));
  }
}
