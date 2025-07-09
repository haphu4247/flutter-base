import 'dart:async';

import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:base_flutter/languages/locale_provider.dart';
import 'package:base_flutter/plugin/firebase/fcm_manager/fcm_manager.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void startApp(Env env) {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      IFcmManager.init(env: env);
      await DIConfig.init(env);

      runApp(_AppBase(env: env));
    },
    AppLogger.onError,
  );
}

class _AppBase extends StatelessWidget {
  const _AppBase({required this.env});
  final Env env;
  @override
  Widget build(BuildContext context) {
    final appThemes = context.appThemes;
    final localeProvider = getIt.get<LocaleProvider>();
    return ValueListenableBuilder<Locale>(
      valueListenable: localeProvider.localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp.router(
          title: AppLocalizations.of(context)?.appVariant(env.name) ?? env.name,
          debugShowCheckedModeBanner: false,
          theme: appThemes.selectedTheme,
          darkTheme: appThemes.darkTheme,
          themeMode: appThemes.themeMode,
          locale: locale,
          localizationsDelegates: localeProvider.localizationsDelegates,
          supportedLocales: localeProvider.supportedLocales,
          routerConfig: AppPages.router,
          builder: FlutterSmartDialog.init(
            loadingBuilder: (msg) => const LoadingView(),
            // toastBuilder: (msg) => ,
            builder: (context, child) {
              return child ?? const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
