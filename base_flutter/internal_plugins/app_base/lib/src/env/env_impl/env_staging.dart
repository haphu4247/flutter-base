import 'package:app_base/src/env/env.dart';

import 'dart:async';

import '../base_env_model.dart';

class EnvStaging extends BaseEnvModel {
  const EnvStaging() : super(env: Env.staging);

  @override
  String get apiHost => 'https://api.binance.com/';

  @override
  FutureOr initConfig() {
    return Future.value(null);
  }
}
