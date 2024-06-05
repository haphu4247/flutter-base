import 'package:app_base/app_base.dart';

enum PublicApi {
  coin;

  _PublicApiSetup get init {
    return _PublicApiSetup(this);
  }
}

class _PublicApiSetup extends BaseApiSetup {
  _PublicApiSetup(PublicApi apiType) : _apiType = apiType;
  final PublicApi _apiType;

  @override
  String getPath(dynamic appendPath) {
    switch (_apiType) {
      case PublicApi.coin:
        return 'api/v3/ticker/24hr';
    }
  }

  @override
  HTTPMethod get method {
    switch (_apiType) {
      default:
        return HTTPMethod.get;
    }
  }

  @override
  String get apiName => _apiType.name;
}
