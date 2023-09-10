import '../../../base/api_client/base_api_setup.dart';

enum PublicApi {
  coin,
}

class PublicApiSetup extends BaseApiSetup {
  PublicApiSetup(PublicApi apiType) : _apiType = apiType;
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
