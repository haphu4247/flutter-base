import 'package:app_base/src/env/env.dart';

import 'dart:async';

import '../base_env_model.dart';

class EnvDev extends BaseEnvModel {
  const EnvDev() : super(env: Env.dev);

  @override
  String get apiHost => 'https://api.binance.com/';

  @override
  FutureOr initConfig() {
    return Future.value(null);
  }
}
