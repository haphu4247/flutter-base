import 'dart:convert';

import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/languages/locale_provider.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class UtilsString {
  UtilsString._internal();

  static String parse(dynamic msg) {
    if (msg != null) {
      return msg.toString();
    }
    return '';
  }

  static String twoDigits(int n) => n.toString().padLeft(2, '0');

  static String format(String s, List<dynamic> list) {
    return sprintf(s, list);
  }

  static String currency(int? total) {
    if (total == null) {
      return '0';
    }
    final locale = getIt.get<LocaleProvider>().currentLocale;

    // final country = locale.countryCode;
    final currency = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return currency.format(total);
  }
  
  static String parseCurrencyFrom(String? source) {
    if (source != null) {
      final amount = int.tryParse(source);
      if (amount != null) {
        return currency(amount);
      }
    }
    return '0';
  }

  static String parseUtf8(String? text) {
    if (text?.isEmpty == true) {
      return '';
    }
    return utf8.decode(text!.runes.toList(), allowMalformed: true);
  }
}