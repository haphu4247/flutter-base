import 'package:base_flutter/flavour/config/config_base.dart';
import 'package:base_flutter/flavour/flavour.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../base/styles/themes/app_themes.dart';

abstract class IAppConfig {
  factory IAppConfig() {
    return _IAppConfigImpl();
  }

  IAppConfig._internal();

  Future<dynamic> initConfig(Flavour flavour);

  Locale get selectedLocales;

  ThemeMode get themeMode;

  ConfigBase get config;
}

class _IAppConfigImpl extends IAppConfig {
  _IAppConfigImpl() : super._internal();

  late final ConfigBase _config;

  Locale? _selectedLocales;

  ThemeMode? _themeMode;

  bool isWeb = kIsWeb;

  @override
  Future<dynamic> initConfig(Flavour flavour) {
    _config = ConfigBase(flavour);
    // LocalRepository().initData();
    final AppThemes appTheme = AppThemes.instance;
    return Future.wait([
      _config.initConfig(),
      _loadLocales(),
      appTheme.loadTheme(),
    ]);
  }

  @override
  Locale get selectedLocales {
    if (_selectedLocales != null) {
      return _selectedLocales!;
    }
    return AppLocalizations.supportedLocales.first;
  }

  @override
  ThemeMode get themeMode {
    if (_themeMode != null) {
      return _themeMode!;
    }
    return ThemeMode.system;
  }

  Future<Locale> _loadLocales() async {
    // final String? myLocale = await LocalRepository().appLocale();
    // return AppLanguages.getLocaleFromLanguage(langCode: myLocale);
    return const Locale('en');
  }

  @override
  ConfigBase get config => _config ?? ConfigBase(Flavour.dev);
}
