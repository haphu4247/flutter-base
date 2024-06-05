import 'package:app_base/app_base.dart';

import 'models/public_api/coin_list_response.dart';
import 'public_api_setup.dart';

class PublicRepository<T extends BaseApiService> {
  PublicRepository(this._apiClient);

  final T _apiClient;

  Future<List<CoinModel>> listCoin() {
    return _apiClient.callList<CoinModel>(PublicApi.coin.init, generator: CoinModel.fromJson,);
  }
}
