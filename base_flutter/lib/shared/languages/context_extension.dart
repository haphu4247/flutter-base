import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LanguageExt on BuildContext {
  AppLocalizations get localize {
    final localize = AppLocalizations.of(this);
    if (localize != null) {
      return localize;
    }
    return lookupAppLocalizations(const Locale('en'));
  }
}
