import 'dart:async';

import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/base/widgets/future_view.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'resources/themes/app_themes.dart';
void startApp(Env env) {
  return runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(_AppBase(env: env));
    },
    AppLogger.onError,
  );
}

class _AppBase extends StatefulWidget {
  const _AppBase({
    Key? key,
    required this.env,
  }) : super(key: key);
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
    return FutureView(
      future: DIConfig().initConfig(widget.env),
      view: MaterialApp.router(
        // title: AppLocalizations.of(context).appVariant(widget.flavour.name),
        debugShowCheckedModeBanner: false,
        theme: AppThemes.instance.light,
        darkTheme: AppThemes.instance.dark,
        // themeMode: flavour.themeMode,
        // locale: flavour.selectedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppPages.router,
      ),
    );
  }
}
