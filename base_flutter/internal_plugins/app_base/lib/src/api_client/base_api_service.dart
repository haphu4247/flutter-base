import 'dart:io';
import 'dart:async';
import 'package:app_base/src/api_client/intercepters/retry_intercepter.dart';
import 'package:app_base/src/models/base_model.dart';
import 'package:app_base/src/models/my_response.dart';
import 'package:app_base/src/tracking_logger/logger_view.dart';
import 'package:dio/dio.dart';
import 'base_api_setup.dart';
import 'base_params.dart';

import 'package:path/path.dart' as p;

part 'base_api_service_impl.dart';

abstract class BaseApiService {
  factory BaseApiService(
      {required String apiHost, bool observeLogger = false}) {
    final options = BaseOptions(
      baseUrl: apiHost,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      sendTimeout: const Duration(seconds: 45),
    );
    final dio = Dio(options);
    dio.interceptors.add(
      RetryInterceptor(dio: dio),
    );
    if (observeLogger) {
      LoggerView.instance.observeLogger(dio.interceptors);
    }

    return _BaseApiServiceImpl(dio: dio);
  }
  const BaseApiService._internal();

  Future<MyResponse<T>> callApi<T extends BaseModel>(
    BaseApiSetup apiSetup, {
    String? appendPath,
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headerParams,
  });

  Future<T> callObj<T extends BaseModel>(
    BaseApiSetup apiSetup, {
    String? appendPath,
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headerParams,
    required T Function(dynamic json) generator,
  });

  Future<List<T>> callList<T extends BaseModel>(
    BaseApiSetup apiSetup, {
    String? appendPath,
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headerParams,
    required T Function(dynamic json) generator,
  });

  Future<MyResponse<T>> uploadFile<T extends BaseModel>(
    BaseApiSetup apiSetup,
    String userId,
    String accessToken,
    List<File> body, {
    String? appendPath,
  });

  Map<String, String> getAuthHeader(String accessToken) {
    return {
      'authorization': 'Bearer $accessToken',
      'accept': 'application/json'
    };
  }
}