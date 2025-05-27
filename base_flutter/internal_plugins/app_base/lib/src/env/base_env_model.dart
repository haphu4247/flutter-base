import 'dart:async';
import 'package:app_base/src/env/env_impl/env_dev.dart';
import 'package:app_base/src/env/env_impl/env_staging.dart';

import 'env.dart';
import 'env_impl/env_prod.dart';

abstract class BaseEnvModel {
  const BaseEnvModel({required this.env});
  factory BaseEnvModel.instance({required Env env}) {
    switch (env) {
      case Env.staging:
        return EnvStaging();
      case Env.prod:
        return EnvProd();
      case Env.dev:
        return EnvDev();
    }
  }
  final Env env;

  String get appIcon;

  FutureOr<dynamic> initConfig();

  String get apiHost;

  bool get observeLogger => false;

  bool get enableCrashlytics => false;
}
