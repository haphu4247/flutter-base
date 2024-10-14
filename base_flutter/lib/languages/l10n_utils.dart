import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10nUtils {
  const L10nUtils._();

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      AppLocalizations.localizationsDelegates;

  static AppLocalizations l10n(BuildContext context) {
    final localize = AppLocalizations.of(context);
    if (localize != null) {
      return localize;
    }
    return lookupAppLocalizations(const Locale('en'));
  }
}
