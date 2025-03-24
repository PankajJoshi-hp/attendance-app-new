import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageController extends GetxController {
  Rx<Locale> locale = Locale('en', 'US').obs;
  RxBool isLoading = true.obs;

  List<Map> list = [
    {'name': 'Eng', 'language': Locale('en', 'US')},
    {'name': 'Hin', 'language': Locale('hi', 'IN')},
    {'name': 'Arb', 'language': Locale('ar', 'AE')},
  ];

  @override
  void onInit() {
    super.onInit();
    loadLocale();
  }

  Future<void> loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocale = prefs.getString('savedLang');

    locale.value = _getLocale(savedLocale);
    isLoading.value = false;
  }

  Locale _getLocale(String? savedLocale) {
    if (savedLocale == 'hi_IN') {
      return Locale('hi', 'IN');
    } else if (savedLocale == 'ar_AE') {
      return Locale('ar', 'AE');
    } else {
      return Locale('en', 'US');
    }
  }

  void updateLocale(Locale newLocale) async {
    locale.value = newLocale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedLang', '${newLocale.languageCode}_${newLocale.countryCode}');
    Get.updateLocale(newLocale);
  }
}
