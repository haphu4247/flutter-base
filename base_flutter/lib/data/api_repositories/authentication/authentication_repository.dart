import 'package:app_base/app_base.dart';

import 'models/login_response.dart';

class AuthenticationRepository<T extends BaseApiService> {
  const AuthenticationRepository(this._apiClient);

  final T _apiClient;

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final params = ApiParams(
      path: '/auth/login',
      method: HttpMethod.post,
      data: {
        'username': username,
        'password': password,
      },
    );
    return _apiClient.callObj<LoginResponse>(
        params: params,
        parser: (json) {
          return LoginResponse.fromJson(json as Map<String, dynamic>);
        });
  }
}
