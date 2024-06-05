import 'package:app_base/app_base.dart';

enum AccountApi {
  accountInfo,
  signup,
  update,
  remove,
  updateName,
  changeAvatar;

  BaseApiSetup get init {
    return _AccountApiSetup(this);
  }
}

class _AccountApiSetup extends BaseApiSetup {
  _AccountApiSetup(AccountApi apiType) : _apiType = apiType;
  final AccountApi _apiType;

  @override
  String getPath(dynamic appendPath) {
    switch (_apiType) {
      case AccountApi.accountInfo:
        return 'api/account';
      case AccountApi.signup:
        return 'api/account/signup';
      case AccountApi.update:
        return 'api/account';
      case AccountApi.remove:
        return 'api/account/$appendPath';
      case AccountApi.updateName:
        return 'api/account/name';
      case AccountApi.changeAvatar:
        return 'api/account/avatar';
    }
  }

  @override
  HTTPMethod get method {
    switch (_apiType) {
      case AccountApi.accountInfo:
        return HTTPMethod.get;
      case AccountApi.signup:
      case AccountApi.update:
      case AccountApi.updateName:
      case AccountApi.changeAvatar:
        return HTTPMethod.post;
      case AccountApi.remove:
        return HTTPMethod.delete;
    }
  }

  @override
  String get apiName => _apiType.name;
}
