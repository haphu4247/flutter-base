import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/languages/l10n_utils.dart';
import 'package:base_flutter/routes/route_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modular_themes/modular_themes.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get lang => L10nUtils.l10n(this);

  BaseEnvModel get env {
    return getIt.get<BaseEnvModel>();
  }

  RouteNavigation get navigation => RouteNavigation.of(this);

  ThemeData get theme => Theme.of(this);

  AppThemes get appThemes => getIt.get<AppThemes>();

  AppColors get appColors => appThemes.appColors;

  AppTextStyles get textStyles => AppTextStyles(appThemes.appColors);

  AppDecoration get appDecoration => AppDecoration(appThemes.appColors);
}
