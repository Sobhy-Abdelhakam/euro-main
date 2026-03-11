// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Euro Assist';

  @override
  String get homeTitle => 'Euro Assist';

  @override
  String get homeNeedHelp => 'Need help right now?';

  @override
  String get homeNeedHelpDescription => 'Tap SOS for immediate roadside or medical assistance.';

  @override
  String get homeServicesInfoTitle => 'Services & Information';

  @override
  String get homeMenuServicesTitle => 'Services';

  @override
  String get homeMenuServicesSubtitle => 'Roadside & medical coverage';

  @override
  String get homeMenuContactTitle => 'Contact';

  @override
  String get homeMenuContactSubtitle => 'Call, WhatsApp, or email us';

  @override
  String get homeMenuAboutTitle => 'About';

  @override
  String get homeMenuAboutSubtitle => 'Learn about Euro Assist';

  @override
  String get sosTitle => 'Emergency SOS';

  @override
  String get sosDescription => 'Share your location and details with our team in seconds.';

  @override
  String get sosButton => 'Send SOS now';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get contactTitle => 'Contact Us';

  @override
  String get contactGetInTouch => 'Get in touch';

  @override
  String get contactDescription => 'Reach Euro Assist anytime for medical or roadside emergencies.';

  @override
  String get contactWhatsAppMedical => 'WhatsApp (Medical)';

  @override
  String get contactWhatsAppRoadside => 'WhatsApp (Roadside)';

  @override
  String get contactEmailMedical => 'Email (Medical)';

  @override
  String get contactEmailRoadside => 'Email (Roadside)';

  @override
  String get contactLandline => 'Landline';

  @override
  String get contactWebsite => 'Website';

  @override
  String get contactErrorWhatsApp => 'Could not open WhatsApp. Please install WhatsApp or open from browser.';

  @override
  String get contactErrorEmail => 'No email client installed.';

  @override
  String get contactErrorPhone => 'Phone call is unavailable.';

  @override
  String get contactErrorWebsite => 'Could not open website.';

  @override
  String get aboutTitle => 'About Us';

  @override
  String get aboutHeaderTitle => 'Euro Assist';

  @override
  String get aboutHeaderSubtitle => 'Your partner for roadside and medical assistance.';

  @override
  String get aboutErrorLoad => 'Failed to load content. Please try again later.';

  @override
  String get commonRetry => 'Retry';

  @override
  String get sosSheetTitle => 'Request Assistance';

  @override
  String get sosSheetNameLabel => 'Name';

  @override
  String get sosSheetNameRequired => 'Please enter your name';

  @override
  String get sosSheetMobileLabel => 'Mobile';

  @override
  String get sosSheetMobileRequired => 'Please enter a mobile number';

  @override
  String get sosSheetMobileInvalid => 'Please enter a valid mobile number';

  @override
  String get sosSheetServiceTypeLabel => 'Service Type';

  @override
  String get sosSheetServiceTypeRoadside => 'Roadside Assistance';

  @override
  String get sosSheetServiceTypeMedical => 'Medical Assistance';

  @override
  String get sosSheetSendButton => 'SEND SOS';

  @override
  String get sosSheetLocationSnackbar => 'Unable to get your location. Please try again.';

  @override
  String get sosSheetLocationTitle => 'Location';

  @override
  String get sosSheetLocationRetry => 'Retry location';

  @override
  String get sosSheetYourLocation => 'Your Location';

  @override
  String get sosSheetLoadingAddress => 'Loading address...';

  @override
  String get sosSheetChooseAnotherLocation => 'Choose another location';

  @override
  String sosSheetFailure(Object error) => 'Failed to send request: $error';

  @override
  String get sosSheetSuccess => 'SOS Request Sent Successfully';

  @override
  String get imagePickerTitle => 'Attach Images (optional)';

  @override
  String get imagePickerButton => 'Add Images';

  @override
  String get servicesAppBarTitle => 'Services';

  @override
  String get servicesError => 'Unable to load services. Please try again.';

  @override
  String get servicesIndividualTitle => 'Individual Services';

  @override
  String get servicesCorporateTitle => 'Corporate Services';

  @override
  String get servicesEmpty => 'No services available at the moment. Please check back later.';

  @override
  String get commonRetryButton => 'Retry';

  @override
  String get locationServiceDisabled => 'Location services are disabled. Please enable GPS.';

  @override
  String get locationPermissionDenied => 'Location permission denied. Please enable it from system settings.';

  @override
  String get servicesHomeTitle => 'Services';

  @override
  String get servicesHomeSosLabel => 'SOS';

  @override
  String get servicesHomeHeader => 'Choose the type of assistance';

  @override
  String get servicesHomeDescription =>
      'Browse the full list of Euro Assist services for roadside and medical support.';

  @override
  String get servicesHomeRoadsideTitle => 'Roadside Assistance';

  @override
  String get servicesHomeMedicalTitle => 'Medical Assistance';

  @override
  String get servicesHomeCardSubtitle => 'Coverage, benefits, and detailed service list.';

  @override
  String get serviceDetailsIncludedServices => 'Included Services';
}
