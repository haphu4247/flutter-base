import 'dart:async';

import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/languages/locale_provider.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void startApp(Env env) {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DIConfig.instance.initConfig(env);

      runApp(_AppBase(env: env));
    },
    AppLogger.onError,
  );
}

class _AppBase extends StatefulWidget {
  const _AppBase({super.key, required this.env});
  final Env env;

  @override
  State<_AppBase> createState() => _AppBaseState();
}

class _AppBaseState extends State<_AppBase> {
  @override
  Widget build(BuildContext context) {
    final appThemes = context.appThemes;
    final localeProvider = getIt.get<LocaleProvider>();
    return ValueListenableBuilder<Locale>(
      valueListenable: localeProvider.localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp.router(
          title: AppLocalizations.of(context)?.appVariant(widget.env.name) ??
              widget.env.name,
          debugShowCheckedModeBanner: false,
          theme: appThemes.selectedTheme,
          darkTheme: appThemes.darkTheme,
          themeMode: appThemes.themeMode,
          locale: locale,
          localizationsDelegates: localeProvider.localizationsDelegates,
          supportedLocales: localeProvider.supportedLocales,
          routerConfig: AppPages.router,
        );
      },
    );
  }
}
