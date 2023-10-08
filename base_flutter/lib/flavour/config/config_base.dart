import 'package:base_flutter/flavour/flavour.dart';

import 'config_prod.dart';
import 'config_staging.dart';

abstract class ConfigBase {
  factory ConfigBase(Flavour environment) {
    switch (environment) {
      case Flavour.prod:
        return ProdConfig(environment);
      case Flavour.dev:
      case Flavour.staging:
        return StagingConfig(environment);
    }
  }
  String get apiHost;

  Flavour get env;
}
