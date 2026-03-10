import 'dart:async';

import 'package:euro/injection.dart';
import 'package:euro/l10n/app_localizations.dart';
import 'package:euro/screens/about_us/cubit/about_us_cubit.dart';
import 'package:euro/screens/app_config/app_config_cubit.dart';
import 'package:euro/screens/service_details/cubit/service_details_cubit.dart';
import 'package:euro/screens/splash/splash_screen.dart';
import 'package:euro/screens/terms_of_use/cubit/terms_of_use_cubit.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveUtils.init();
  injection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme() {
    return ThemeData(
      fontFamily: HiveUtils.getLanguage == 'en' ? 'Poppins' : 'NotoNaskhArabic',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(8),
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Color(0xff292929)),
        titleTextStyle: TextStyle(color: Color(0xff292929)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => MedicalServicesCubit(),
          // ),
          // BlocProvider(
          //   create: (context) => SubServicesCubit()..getServices(),
          // ),
          BlocProvider(
            create: (context) => ServiceDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => AppConfigCubit(),
          ),
          // BlocProvider(
          //   create: (context) => RoadsideAssistServicesCubit(),
          // ),
          BlocProvider(
            create: (context) => AboutUsCubit()..getString(),
          ),
          BlocProvider(
            create: (context) => TermsOfUseCubit()..getString(),
          )
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, __) {
              return BlocBuilder<AppConfigCubit, AppConfigState>(
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Euro Assist',
                    locale: Locale(HiveUtils.getLanguage),
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    theme: _buildTheme(),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(0.9)),
                        child: ResponsiveBreakpoints.builder(
                          child: child!,
                          breakpoints: [
                            const Breakpoint(start: 0, end: 450, name: MOBILE),
                            const Breakpoint(
                                start: 451, end: 800, name: TABLET),
                            const Breakpoint(
                                start: 801, end: 1920, name: DESKTOP),
                            const Breakpoint(
                                start: 1921, end: double.infinity, name: '4K'),
                          ],
                        ),
                      );
                    },
                    home: const SplashScreen(),
                  );
                },
              );
            }));
  }
}
