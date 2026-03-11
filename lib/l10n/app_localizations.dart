import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Euro Assist'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Euro Assist'**
  String get homeTitle;

  /// No description provided for @homeNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help right now?'**
  String get homeNeedHelp;

  /// No description provided for @homeNeedHelpDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap SOS for immediate roadside or medical assistance.'**
  String get homeNeedHelpDescription;

  /// No description provided for @homeServicesInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Services & Information'**
  String get homeServicesInfoTitle;

  /// No description provided for @homeMenuServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get homeMenuServicesTitle;

  /// No description provided for @homeMenuServicesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Roadside & medical coverage'**
  String get homeMenuServicesSubtitle;

  /// No description provided for @homeMenuContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get homeMenuContactTitle;

  /// No description provided for @homeMenuContactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Call, WhatsApp, or email us'**
  String get homeMenuContactSubtitle;

  /// No description provided for @homeMenuAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get homeMenuAboutTitle;

  /// No description provided for @homeMenuAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn about Euro Assist'**
  String get homeMenuAboutSubtitle;

  /// No description provided for @sosTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get sosTitle;

  /// No description provided for @sosDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your location and details with our team in seconds.'**
  String get sosDescription;

  /// No description provided for @sosButton.
  ///
  /// In en, this message translates to:
  /// **'Send SOS now'**
  String get sosButton;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @contactTitle.
  String get contactTitle;

  /// No description provided for @contactGetInTouch.
  String get contactGetInTouch;

  /// No description provided for @contactDescription.
  String get contactDescription;

  /// No description provided for @contactWhatsAppMedical.
  String get contactWhatsAppMedical;

  /// No description provided for @contactWhatsAppRoadside.
  String get contactWhatsAppRoadside;

  /// No description provided for @contactEmailMedical.
  String get contactEmailMedical;

  /// No description provided for @contactEmailRoadside.
  String get contactEmailRoadside;

  /// No description provided for @contactLandline.
  String get contactLandline;

  /// No description provided for @contactWebsite.
  String get contactWebsite;

  /// No description provided for @contactErrorWhatsApp.
  String get contactErrorWhatsApp;

  /// No description provided for @contactErrorEmail.
  String get contactErrorEmail;

  /// No description provided for @contactErrorPhone.
  String get contactErrorPhone;

  /// No description provided for @contactErrorWebsite.
  String get contactErrorWebsite;

  /// No description provided for @aboutTitle.
  String get aboutTitle;

  /// No description provided for @aboutHeaderTitle.
  String get aboutHeaderTitle;

  /// No description provided for @aboutHeaderSubtitle.
  String get aboutHeaderSubtitle;

  /// No description provided for @aboutErrorLoad.
  String get aboutErrorLoad;

  /// No description provided for @commonRetry.
  String get commonRetry;

  /// No description provided for @sosSheetTitle.
  String get sosSheetTitle;

  /// No description provided for @sosSheetNameLabel.
  String get sosSheetNameLabel;

  /// No description provided for @sosSheetNameRequired.
  String get sosSheetNameRequired;

  /// No description provided for @sosSheetMobileLabel.
  String get sosSheetMobileLabel;

  /// No description provided for @sosSheetMobileRequired.
  String get sosSheetMobileRequired;

  /// No description provided for @sosSheetMobileInvalid.
  String get sosSheetMobileInvalid;

  /// No description provided for @sosSheetServiceTypeLabel.
  String get sosSheetServiceTypeLabel;

  /// No description provided for @sosSheetServiceTypeRoadside.
  String get sosSheetServiceTypeRoadside;

  /// No description provided for @sosSheetServiceTypeMedical.
  String get sosSheetServiceTypeMedical;

  /// No description provided for @sosSheetSendButton.
  String get sosSheetSendButton;

  /// No description provided for @sosSheetLocationSnackbar.
  String get sosSheetLocationSnackbar;

  /// No description provided for @sosSheetLocationTitle.
  String get sosSheetLocationTitle;

  /// No description provided for @sosSheetLocationRetry.
  String get sosSheetLocationRetry;

  /// No description provided for @sosSheetYourLocation.
  String get sosSheetYourLocation;

  /// No description provided for @sosSheetLoadingAddress.
  String get sosSheetLoadingAddress;

  /// No description provided for @sosSheetChooseAnotherLocation.
  String get sosSheetChooseAnotherLocation;

  /// No description provided for @sosSheetFailure.
  String sosSheetFailure(Object error);

  /// No description provided for @sosSheetSuccess.
  String get sosSheetSuccess;

  /// No description provided for @imagePickerTitle.
  String get imagePickerTitle;

  /// No description provided for @imagePickerButton.
  String get imagePickerButton;

  /// No description provided for @servicesAppBarTitle.
  String get servicesAppBarTitle;

  /// No description provided for @servicesError.
  String get servicesError;

  /// No description provided for @servicesIndividualTitle.
  String get servicesIndividualTitle;

  /// No description provided for @servicesCorporateTitle.
  String get servicesCorporateTitle;

  /// No description provided for @servicesEmpty.
  String get servicesEmpty;

  /// No description provided for @commonRetryButton.
  String get commonRetryButton;

  /// No description provided for @locationServiceDisabled.
  String get locationServiceDisabled;

  /// No description provided for @locationPermissionDenied.
  String get locationPermissionDenied;

  /// No description provided for @servicesHomeTitle.
  String get servicesHomeTitle;

  /// No description provided for @servicesHomeSosLabel.
  String get servicesHomeSosLabel;

  /// No description provided for @servicesHomeHeader.
  String get servicesHomeHeader;

  /// No description provided for @servicesHomeDescription.
  String get servicesHomeDescription;

  /// No description provided for @servicesHomeRoadsideTitle.
  String get servicesHomeRoadsideTitle;

  /// No description provided for @servicesHomeMedicalTitle.
  String get servicesHomeMedicalTitle;

  /// No description provided for @servicesHomeCardSubtitle.
  String get servicesHomeCardSubtitle;

  /// No description provided for @serviceDetailsIncludedServices.
  String get serviceDetailsIncludedServices;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
