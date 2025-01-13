import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/data/api_repositories/public/models/public_api/coin_list_response.dart';
import 'package:base_flutter/data/api_repositories/public/public_repository.dart';
import 'package:flutter/material.dart';

class PublicApiController extends BaseController {

  @override
  void onInit() {
    loadCoins();
  }

  final String title = 'Test Fetching API';
  PublicRepository? repo;
  final ValueNotifier<List<CoinModel>?> coins = ValueNotifier(null);

  void loadCoins() {
    repo = getIt.get<PublicRepository>();
    if (repo != null) {
      List<CoinModel>? result;
      repo!.listCoin().then((value) {
        result = value;
      }).whenComplete(() {
        if (result == null) {
          coins.value = [];
        } else {
          coins.value = result;
        }
      });
    } else {
      coins.value = [];
    }
  }

  
}
