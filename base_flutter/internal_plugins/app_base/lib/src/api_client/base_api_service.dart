import 'dart:io';
import 'dart:async';
import 'package:app_base/app_base.dart';
import 'package:app_base/src/api_client/intercepters/retry_intercepter.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

part 'base_api_service_impl.dart';

abstract class BaseApiService {
  factory BaseApiService({required String apiHost}) {
    final options = BaseOptions(
      baseUrl: apiHost,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      sendTimeout: const Duration(seconds: 45),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    );
    final dio = Dio(options);
    dio.interceptors.add(RetryInterceptor(dio: dio));
    AppLogger.printDebugLog(dio);
    return _BaseApiServiceImpl(dio);
  }
  const BaseApiService._internal(this.dio);

  final Dio dio;

  Future<ApiResponseModel> _requestData(ApiParams params) {
    return dio
        .request(
      params.path,
      queryParameters: params.queryParameters,
      options: params.options,
      data: params.data,
    )
        .then((value) {
      return ApiResponseModel(
        requestOptions: value.requestOptions,
        data: value.data,
        statusCode: value.statusCode,
      );
    });
  }

  Future<ApiResponseModel> callApi(
      {required ApiParams params});

  Future<T> callObj<T extends BaseModel>({
    required ApiParams params,
    required T Function(dynamic json) parser,
  });

  Future<List<T>> callList<T extends BaseModel>({
    required ApiParams params,
    required T Function(dynamic json) parser,
  });

  Future<ApiResponseModel> uploadFile({
    required ApiParams params,
    required List<File> body,
  });

  Map<String, String> getAuthHeader(String accessToken) {
    return {
      'authorization': 'Bearer $accessToken',
      'accept': 'application/json'
    };
  }
}
