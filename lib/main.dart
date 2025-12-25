import 'dart:async';
import 'dart:developer' as developer;

import 'package:euro/injection.dart';
import 'package:euro/l10n/app_localizations.dart';
import 'package:euro/screens/about_us/cubit/about_us_cubit.dart';
import 'package:euro/screens/app_config/app_config_cubit.dart';
import 'package:euro/screens/service_details/cubit/service_details_cubit.dart';
import 'package:euro/screens/splash/splash_screen.dart';
import 'package:euro/screens/sub_services/cubit/sub_services_cubit.dart';
import 'package:euro/screens/terms_of_use/cubit/terms_of_use_cubit.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

// import 'generated/l10n.dart';
import 'screens/medical_services/cubit/medical_services_cubit.dart';
import 'screens/roadside_assist_services/cubit/roadside_assist_services_cubit.dart';

/// Logs errors safely for both debug and release modes
void _logError(Object error, StackTrace? stack) {
  if (kDebugMode) {
    developer.log(
      'Error caught by global handler',
      error: error,
      stackTrace: stack,
    );
  }
  // In production, errors are caught silently to prevent crashes
  // You could add crash reporting service here (e.g., Firebase Crashlytics)
}

Future<void> main() async {
  // CRITICAL: Must be called before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Global error handling for synchronous Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _logError(details.exception, details.stack);
  };

  // Global error handling for platform errors (native code crashes)
  PlatformDispatcher.instance.onError = (error, stack) {
    _logError(error, stack);
    return true; // Prevents app crash by handling the error
  };

  // Run app in a guarded zone to catch all async errors
  runZonedGuarded(() async {
    try {
      await HiveUtils.init();
      injection();
      runApp(const MyApp());
    } catch (e, stack) {
      _logError(e, stack);
      // Run a minimal error app if initialization fails
      runApp(const _InitializationErrorApp());
    }
  }, (error, stack) {
    _logError(error, stack);
  });
}

/// Fallback app shown if main initialization fails
class _InitializationErrorApp extends StatelessWidget {
  const _InitializationErrorApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Icon(Icons.error_outline, size: 64, color: Colors.red),
               SizedBox(height: 16),
               Text(
                  'Failed to initialize app',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
               SizedBox(height: 8),
               Text(
                  'Please restart the application',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MedicalServicesCubit(),
          ),
          BlocProvider(
            create: (context) => SubServicesCubit()..getServices(),
          ),
          BlocProvider(
            create: (context) => ServiceDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => AppConfigCubit(),
          ),
          BlocProvider(
            create: (context) => RoadsideAssistServicesCubit(),
          ),
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
            builder: (_, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(0.8),
                ),
                child: BlocBuilder<AppConfigCubit, AppConfigState>(
                  builder: (context, state) {
                    return MaterialApp(
                      locale: Locale(HiveUtils.getLanguage),
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

                      title: 'Euro Assist',
                      builder: (context, child) {
                        return ResponsiveBreakpoints.builder(
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
                        );
                      },
                      theme: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          filled: true,
                          focusColor: Colors.white,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(8.0),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1)),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.4),
                                width: 1,
                              )),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        fontFamily: HiveUtils.getLanguage == 'en'
                            ? 'Poppins'
                            : 'NotoNaskhArabic',
                        appBarTheme: const AppBarTheme(
                            iconTheme: IconThemeData(color: Color(0xff292929)),
                            titleTextStyle:
                                TextStyle(color: Color(0xff292929))),
                      ),
                      home: const SplashScreen(),
                    );
                  },
                ),
              );
            }));
  }
}
