import 'package:app_base/app_base.dart';

import 'models/public_api/coin_list_response.dart';

class PublicRepository<T extends BaseApiService> {
  const PublicRepository(this._apiClient);

  final T _apiClient;

  Future<List<CoinModel>> listCoin() {
    return _apiClient.callList<CoinModel>(
      params:
          const ApiParams(path: 'api/v3/ticker/24hr', method: HttpMethod.get),
      parser: CoinModel.fromJson,
    );
  }
}
