import 'package:base_flutter/flavour/flavour.dart';

import 'config_base.dart';

class StagingConfig implements ConfigBase {
  StagingConfig(this.env);

  @override
  String get apiHost => 'https://phuhp.com';

  @override
  Flavour env;
}
