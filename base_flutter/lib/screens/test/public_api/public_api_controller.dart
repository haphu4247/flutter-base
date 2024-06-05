import 'package:app_base/app_base.dart';
import 'package:base_flutter/data/api_repositories/public/models/public_api/coin_list_response.dart';
import 'package:base_flutter/data/api_repositories/public/public_repository.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';

class PublicApiController extends BaseController {
  final String title = 'Test Fetching API';
  late final PublicRepository repo;

  @override
  void initState() {
    repo = PublicRepository(context.getIt.get<BaseApiService>());
  }

  Future<List<CoinModel>> list() {
    return repo.listCoin();
  }
}
