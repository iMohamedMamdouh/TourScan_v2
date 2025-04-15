import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguageUtil {
  static final ValueNotifier<String> languageCodeNotifier =
      ValueNotifier(Intl.getCurrentLocale());

  static bool get isArabic => languageCodeNotifier.value.startsWith('ar');

  static void updateLocale(String locale) {
    languageCodeNotifier.value = locale;
  }
}
