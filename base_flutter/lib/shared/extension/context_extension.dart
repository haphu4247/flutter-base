import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get localize {
    final localize = AppLocalizations.of(this);
    if (localize != null) {
      return localize;
    }
    return lookupAppLocalizations(const Locale('en'));
  }

  BaseEnvModel get env {
    return DIConfig().getIt.get<BaseEnvModel>();
  }

  GetIt get getIt {
    return DIConfig().getIt;
  }
}
