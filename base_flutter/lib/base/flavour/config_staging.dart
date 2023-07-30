import 'base_config.dart';
import 'flavour.dart';

class StagingConfig implements BaseConfig {
  StagingConfig(this.env);

  @override
  String get apiHost => 'https://phuhp.com';

  @override
  bool get showBanner => false;

  @override
  Flavour env;
}
