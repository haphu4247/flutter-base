import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app/app_config.dart';
import 'base/styles/themes/app_themes.dart';
import 'flavour/flavour.dart';

Future<dynamic> startApp(Flavour flavour) {
  WidgetsFlutterBinding.ensureInitialized();
  return Future.wait([
    DIConfig().initConfig(flavour),
  ]).whenComplete(() {
    runApp(_AppBase(flavour: flavour));
  });
}

class _AppBase extends StatefulWidget {
  const _AppBase({
    Key? key,
    required this.flavour,
  }) : super(key: key);
  final Flavour flavour;

  @override
  State<_AppBase> createState() => _AppBaseState();
}

class _AppBaseState extends State<_AppBase> {
  @override
  Widget build(BuildContext context) {
    final flavour = IAppConfig();
    return MaterialApp.router(
      // title: AppLocalizations.of(context).appVariant(widget.flavour.name),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.instance.light,
      darkTheme: AppThemes.instance.dark,
      themeMode: flavour.themeMode,
      locale: flavour.selectedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppPages.router,
    );
  }
}
