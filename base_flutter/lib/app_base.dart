import 'dart:async';

import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/languages/l10n_utils.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'resources/themes/app_themes.dart';

void startApp(Env env) {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DIConfig().initConfig(env);
      runApp(_AppBase(env: env));
    },
    AppLogger.onError,
  );
}

class _AppBase extends StatefulWidget {
  const _AppBase({
    super.key,
    required this.env,
  });
  final Env env;

  @override
  State<_AppBase> createState() => _AppBaseState();
}

class _AppBaseState extends State<_AppBase> {
  @override
  void initState() {
    AppLogger.console(this, 'init Base App');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // title: AppLocalizations.of(context).appVariant(widget.flavour.name),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.instance.light,
      darkTheme: AppThemes.instance.dark,
      // themeMode: flavour.themeMode,
      // locale: flavour.selectedLocales,
      localizationsDelegates: L10nUtils.localizationsDelegates,
      supportedLocales: L10nUtils.supportedLocales,
      routerConfig: AppPages.router,
    );
  }
}
