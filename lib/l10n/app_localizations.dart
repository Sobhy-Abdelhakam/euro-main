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

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'WELCOME TO'**
  String get welcome;

  /// No description provided for @roadside_services.
  ///
  /// In en, this message translates to:
  /// **'Roadside Assist Services'**
  String get roadside_services;

  /// No description provided for @medical_services.
  ///
  /// In en, this message translates to:
  /// **'Medical Services'**
  String get medical_services;

  /// No description provided for @requestAssistance.
  ///
  /// In en, this message translates to:
  /// **'Request Assistance'**
  String get requestAssistance;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Profile Name'**
  String get profileName;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'help'**
  String get help;

  /// No description provided for @terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Use'**
  String get terms_of_use;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'info'**
  String get info;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @individuals.
  ///
  /// In en, this message translates to:
  /// **'Roadside Assist services'**
  String get individuals;

  /// No description provided for @corporates.
  ///
  /// In en, this message translates to:
  /// **'Cooperate services'**
  String get corporates;

  /// No description provided for @service_details.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get service_details;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @requestAMembership.
  ///
  /// In en, this message translates to:
  /// **'Request Membership'**
  String get requestAMembership;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type message'**
  String get typeMessage;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get user_name;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'share'**
  String get share;

  /// No description provided for @document_id.
  ///
  /// In en, this message translates to:
  /// **'Document Id'**
  String get document_id;

  /// No description provided for @document_source.
  ///
  /// In en, this message translates to:
  /// **'Document Source'**
  String get document_source;

  /// No description provided for @car_type.
  ///
  /// In en, this message translates to:
  /// **'Car Type'**
  String get car_type;

  /// No description provided for @car_model.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get car_model;

  /// No description provided for @car_numbers.
  ///
  /// In en, this message translates to:
  /// **'Car Numbers'**
  String get car_numbers;

  /// No description provided for @car_letters.
  ///
  /// In en, this message translates to:
  /// **'Car Letters'**
  String get car_letters;

  /// No description provided for @chassis_Number.
  ///
  /// In en, this message translates to:
  /// **'Chassis Number'**
  String get chassis_Number;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @emptyField.
  ///
  /// In en, this message translates to:
  /// **'{filedName} Field Must not be Empty'**
  String emptyField(Object filedName);

  /// No description provided for @saved_successfully.
  ///
  /// In en, this message translates to:
  /// **'Saved Successfully'**
  String get saved_successfully;

  /// No description provided for @no_changes.
  ///
  /// In en, this message translates to:
  /// **'No Changes'**
  String get no_changes;

  /// No description provided for @check_connectoin.
  ///
  /// In en, this message translates to:
  /// **'check your internet connection'**
  String get check_connectoin;

  /// No description provided for @succeeded.
  ///
  /// In en, this message translates to:
  /// **'Request Sent successfully'**
  String get succeeded;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @it_takes_a_long_time.
  ///
  /// In en, this message translates to:
  /// **'It takes a long time'**
  String get it_takes_a_long_time;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @whatsApp.
  ///
  /// In en, this message translates to:
  /// **'whatsApp'**
  String get whatsApp;

  /// No description provided for @whatsAppContact.
  ///
  /// In en, this message translates to:
  /// **'Contact us via whatsApp'**
  String get whatsAppContact;

  /// No description provided for @landLine.
  ///
  /// In en, this message translates to:
  /// **'LandLine'**
  String get landLine;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @roadside.
  ///
  /// In en, this message translates to:
  /// **'Roadside'**
  String get roadside;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'Copyrights © Euro Assist'**
  String get copyright;

  /// No description provided for @addImages.
  ///
  /// In en, this message translates to:
  /// **'Add Images'**
  String get addImages;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;
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
