// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'يورو أسيست';

  @override
  String get homeTitle => 'يورو أسيست';

  @override
  String get homeNeedHelp => 'تحتاج مساعدة الآن؟';

  @override
  String get homeNeedHelpDescription => 'اضغط SOS للحصول على مساعدة فورية على الطريق أو طبية.';

  @override
  String get homeServicesInfoTitle => 'الخدمات والمعلومات';

  @override
  String get homeMenuServicesTitle => 'الخدمات';

  @override
  String get homeMenuServicesSubtitle => 'تغطية الطريق والطوارئ الطبية';

  @override
  String get homeMenuContactTitle => 'التواصل';

  @override
  String get homeMenuContactSubtitle => 'اتصل بنا أو راسلنا عبر الواتساب أو البريد';

  @override
  String get homeMenuAboutTitle => 'حول';

  @override
  String get homeMenuAboutSubtitle => 'تعرف على يورو أسيست';

  @override
  String get sosTitle => 'طوارئ SOS';

  @override
  String get sosDescription => 'شارك موقعك وتفاصيل حالتك مع فريقنا خلال ثوانٍ.';

  @override
  String get sosButton => 'إرسال SOS الآن';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get contactTitle => 'تواصل معنا';

  @override
  String get contactGetInTouch => 'ابقَ على تواصل';

  @override
  String get contactDescription => 'تواصل مع يورو أسيست في أي وقت لحالات الطوارئ على الطريق أو الطبية.';

  @override
  String get contactWhatsAppMedical => 'واتساب (طبي)';

  @override
  String get contactWhatsAppRoadside => 'واتساب (طريق)';

  @override
  String get contactEmailMedical => 'البريد الإلكتروني (طبي)';

  @override
  String get contactEmailRoadside => 'البريد الإلكتروني (طريق)';

  @override
  String get contactLandline => 'هاتف أرضي';

  @override
  String get contactWebsite => 'الموقع الإلكتروني';

  @override
  String get contactErrorWhatsApp => 'تعذّر فتح واتساب. يرجى تثبيت واتساب أو فتحه من المتصفح.';

  @override
  String get contactErrorEmail => 'لا يوجد تطبيق بريد إلكتروني مثبت.';

  @override
  String get contactErrorPhone => 'تعذّر إجراء مكالمة هاتفية.';

  @override
  String get contactErrorWebsite => 'تعذّر فتح الموقع الإلكتروني.';

  @override
  String get aboutTitle => 'من نحن';

  @override
  String get aboutHeaderTitle => 'يورو أسيست';

  @override
  String get aboutHeaderSubtitle => 'شريكك للمساعدة على الطريق والطوارئ الطبية.';

  @override
  String get aboutErrorLoad => 'تعذّر تحميل المحتوى. يرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get sosSheetTitle => 'طلب مساعدة';

  @override
  String get sosSheetNameLabel => 'الاسم';

  @override
  String get sosSheetNameRequired => 'يرجى إدخال الاسم';

  @override
  String get sosSheetMobileLabel => 'رقم الجوال';

  @override
  String get sosSheetMobileRequired => 'يرجى إدخال رقم الجوال';

  @override
  String get sosSheetMobileInvalid => 'يرجى إدخال رقم جوال صحيح';

  @override
  String get sosSheetServiceTypeLabel => 'نوع الخدمة';

  @override
  String get sosSheetServiceTypeRoadside => 'مساعدة على الطريق';

  @override
  String get sosSheetServiceTypeMedical => 'مساعدة طبية';

  @override
  String get sosSheetSendButton => 'إرسال SOS';

  @override
  String get sosSheetLocationSnackbar => 'تعذّر الحصول على موقعك. يرجى المحاولة مرة أخرى.';

  @override
  String get sosSheetLocationTitle => 'الموقع';

  @override
  String get sosSheetLocationRetry => 'إعادة المحاولة للموقع';

  @override
  String get sosSheetYourLocation => 'موقعك الحالي';

  @override
  String get sosSheetLoadingAddress => 'جاري تحميل العنوان...';

  @override
  String get sosSheetChooseAnotherLocation => 'اختيار موقع آخر';

  @override
  String sosSheetFailure(Object error) => 'فشل إرسال الطلب: $error';

  @override
  String get sosSheetSuccess => 'تم إرسال طلب SOS بنجاح';

  @override
  String get imagePickerTitle => 'إرفاق صور (اختياري)';

  @override
  String get imagePickerButton => 'إضافة صور';

  @override
  String get servicesAppBarTitle => 'الخدمات';

  @override
  String get servicesError => 'تعذّر تحميل الخدمات. يرجى المحاولة مرة أخرى.';

  @override
  String get servicesIndividualTitle => 'خدمات الأفراد';

  @override
  String get servicesCorporateTitle => 'خدمات الشركات';

  @override
  String get servicesEmpty => 'لا توجد خدمات متاحة حاليًا. يرجى المحاولة لاحقًا.';

  @override
  String get commonRetryButton => 'إعادة المحاولة';

  @override
  String get locationServiceDisabled => 'خدمات تحديد الموقع معطّلة. يرجى تفعيل الـ GPS.';

  @override
  String get locationPermissionDenied => 'تم رفض إذن الموقع. يرجى تفعيله من إعدادات النظام.';

  @override
  String get servicesHomeTitle => 'الخدمات';

  @override
  String get servicesHomeSosLabel => 'SOS';

  @override
  String get servicesHomeHeader => 'اختر نوع المساعدة';

  @override
  String get servicesHomeDescription =>
      'تصفّح قائمة خدمات يورو أسيست الكاملة للدعم على الطريق والطوارئ الطبية.';

  @override
  String get servicesHomeRoadsideTitle => 'مساعدة على الطريق';

  @override
  String get servicesHomeMedicalTitle => 'مساعدة طبية';

  @override
  String get servicesHomeCardSubtitle => 'التغطية، المزايا، وقائمة الخدمات التفصيلية.';

  @override
  String get serviceDetailsIncludedServices => 'الخدمات المشمولة';
}
