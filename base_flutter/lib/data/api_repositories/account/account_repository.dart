import 'package:app_base/app_base.dart';

import 'account_api_setup.dart';

class AccountRepository<T extends BaseApiService> {
  AccountRepository(this._apiClient);

  final T _apiClient;

  // Future<MyResponse<>> accountInfo(Map<dynamic, dynamic> body) {

  //   return _apiClient.callApi(AccountApi.accountInfo.init,
  //       body: body);
  // }

  // Future<Response<dynamic>> signup(Map<dynamic, dynamic> body) {
  //   return _apiClient.callApi(AccountApiSetup(AccountApi.signup), body: body);
  // }

  // Future<Response<dynamic>> update(
  //     Map<dynamic, dynamic> body, String accessToken) {
  //   final header = _apiClient.getAuthHeader(accessToken);
  //   return _apiClient.callApi(AccountApiSetup(AccountApi.update),
  //       body: body, headerParams: header);
  // }

  // Future<Response<dynamic>> changeAvatar(Map<dynamic, dynamic> body) {
  //   return _apiClient.callApi(AccountApiSetup(AccountApi.changeAvatar),
  //       body: body);
  // }
}
