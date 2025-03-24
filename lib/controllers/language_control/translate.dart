import 'package:attendance_app_new/controllers/language_control/arabic_lang.dart';
import 'package:attendance_app_new/controllers/language_control/english_lang.dart';
import 'package:attendance_app_new/controllers/language_control/hindi_lang.dart';
import 'package:get/get.dart';


class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': EnglishLang.values,
        'hi_IN': HindiLang.values,
        'ar_AE': ArabicLang.values
      };
}
