import 'package:dio/dio.dart';

import '../../../base/api_client/base_api_service.dart';
import 'public_api_setup.dart';

class PublicRepository<T extends BaseApiService> {
  PublicRepository(this._apiClient);

  final T _apiClient;

  Future<Response<dynamic>> listCoin() {
    return _apiClient.callApi(PublicApiSetup(PublicApi.coin));
  }
}
