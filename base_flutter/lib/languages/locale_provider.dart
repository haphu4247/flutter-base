import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleProvider {
  static const _defaultLocale = Locale('en');

  final ValueNotifier<Locale> localeNotifier =
      ValueNotifier<Locale>(_defaultLocale);
  Locale get currentLocale => localeNotifier.value;

  void setLocale(Locale locale) {
    if (currentLocale.languageCode == locale.languageCode) {
      return;
    }
    switch (locale.languageCode) {
      case 'vi':
        localeNotifier.value = const Locale('vi');
      default:
        localeNotifier.value = _defaultLocale;
    }
  }

  final List<Locale> supportedLocales = AppLocalizations.supportedLocales;

  final List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      AppLocalizations.localizationsDelegates;

  static AppLocalizations l10n(BuildContext context) {
    final localize = AppLocalizations.of(context);
    if (localize != null) {
      return localize;
    }
    return lookupAppLocalizations(_defaultLocale);
  }

  String get originalText {
    switch (currentLocale.languageCode) {
      case 'vi':
        return 'Tiếng Việt';
      case 'ko':
        return '한국인';
      case 'ja':
        return '日本';
      case 'en':
        return 'English';
      default:
        return 'English';
    }
  }

  String get flag {
    switch (currentLocale.languageCode) {
      case 'vi':
        return 'flag_vietnam.png';
      case 'ko':
        return 'flag_south_korea.png';
      case 'ja':
        return 'flag_japan.png';
      case 'en':
        return 'flag_enlish.png';
      default:
        return 'flag_uk.png';
    }
  }
}
