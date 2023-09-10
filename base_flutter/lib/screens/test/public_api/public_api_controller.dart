import 'package:base_flutter/base/api_client/base_api_service.dart';
import 'package:base_flutter/base/base_screen/controller/base_controller.dart';
import 'package:base_flutter/data/api_repositories/public/public_repository.dart';
import 'package:dio/dio.dart';

class PublicApiController extends BaseController {
  final String title = 'Test Fetching API';
  late final PublicRepository repo;

  @override
  void initState() {
    repo = PublicRepository(getIt.get<BaseApiService>());
  }

  Future<Response<dynamic>> list() {
    return repo.listCoin();
  }
}
