import 'package:euro/screens/about_us/cubit/about_us_cubit.dart';
import 'package:euro/screens/app_config/app_config_cubit.dart';
import 'package:euro/screens/medical_services/cubit/medical_services_cubit.dart';
import 'package:euro/screens/roadside_assist_services/cubit/roadside_assist_services_cubit.dart';
import 'package:euro/screens/service_details/cubit/service_details_cubit.dart';
import 'package:euro/screens/sub_services/cubit/sub_services_cubit.dart';
import 'package:euro/screens/terms_of_use/cubit/terms_of_use_cubit.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: 0,
        duration: const Duration(milliseconds: 500),
        child: ScaleAnimation(
          child: FadeInAnimation(
            child: Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        changeLanguage("en", context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(200)),
                        child: const Center(
                          child: Text(
                            "English",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        changeLanguage("ar", context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(200)),
                        child: const Center(
                          child: Text(
                            "العربية",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changeLanguage(String codeLang, BuildContext context) async {
    if (Intl.getCurrentLocale() == codeLang) {
      Navigator.pop(context);
      return;
    }
    BlocProvider.of<AppConfigCubit>(context).setLanguage(codeLang);
    BlocProvider.of<MedicalServicesCubit>(context).getServices();
    BlocProvider.of<SubServicesCubit>(context).getServices();
    BlocProvider.of<ServiceDetailsCubit>(context).getServices();
    BlocProvider.of<TermsOfUseCubit>(context).getString();
    BlocProvider.of<AboutUsCubit>(context).getString();

    BlocProvider.of<RoadsideAssistServicesCubit>(context).getServices();
    Navigator.pop(context);
  }
}
