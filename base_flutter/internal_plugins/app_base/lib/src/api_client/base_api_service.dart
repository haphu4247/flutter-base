import 'dart:io';
import 'dart:async';
import 'package:app_base/src/models/base_model.dart';
import 'package:app_base/src/models/my_response.dart';
import 'package:app_base/src/tracking_logger/logger_view.dart';
import 'package:dio/dio.dart';
import '../tracking_logger/app_logger.dart';
import 'base_api_setup.dart';
import 'base_params.dart';

import 'package:path/path.dart' as p;

abstract class BaseApiService {
  factory BaseApiService(
      {required String apiHost, bool observeLogger = false}) {
    final options = BaseOptions(
      baseUrl: apiHost,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 45),
      sendTimeout: const Duration(seconds: 45),
    );
    final dio = Dio(options);
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

class _BaseApiServiceImpl extends BaseApiService {
  const _BaseApiServiceImpl({required this.dio}) : super._internal();

  final Dio dio;

  @override
  Future<MyResponse<T>> callApi<T extends BaseModel>(
    BaseApiSetup apiSetup, {
    String? appendPath,
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headerParams = const {'accept': 'application/json'},
  }) {
    return _requestData<T>(
      BaseParams(
          apiSetup: apiSetup,
          appendPath: appendPath,
          bodyParams: body,
          headerParams: headerParams,
          queryParams: queryParams),
    );
  }

  @override
  Future<T> callObj<T extends BaseModel>(BaseApiSetup apiSetup,
      {String? appendPath,
      body,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headerParams,
      required T Function(dynamic json) generator}) {
    return _requestData<T>(
      BaseParams(
          apiSetup: apiSetup,
          appendPath: appendPath,
          bodyParams: body,
          headerParams: headerParams,
          queryParams: queryParams),
    ).then((value) {
      return value.parseObject(generator);
    });
  }

  @override
  Future<List<T>> callList<T extends BaseModel>(BaseApiSetup apiSetup,
      {String? appendPath,
      body,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headerParams,
      required T Function(dynamic json) generator}) {
    return _requestData<T>(
      BaseParams(
          apiSetup: apiSetup,
          appendPath: appendPath,
          bodyParams: body,
          headerParams: headerParams,
          queryParams: queryParams),
    ).then((value) {
      return value.parseList(generator);
    });
  }

  @override
  Future<MyResponse<T>> uploadFile<T extends BaseModel>(
    BaseApiSetup apiSetup,
    String userId,
    String accessToken,
    List<File> body, {
    String? appendPath,
  }) {
    final list = body.map(
      (e) => MultipartFile.fromFile(
        e.path,
        filename: p.basename(e.path),
      ),
    );
    final map = <String, dynamic>{
      'file': list,
      'userId': userId,
    };
    final form = FormData.fromMap(map);
    final header = getAuthHeader(accessToken);
    return _requestData<T>(BaseParams(
        appendPath: appendPath,
        apiSetup: apiSetup,
        bodyParams: form,
        headerParams: header));
  }

  Future<MyResponse<T>> _requestData<T extends BaseModel>(
    BaseParams params,
  ) {
    AppLogger.d(this, params.toString());
    return dio
        .request(
          params.url,
          queryParameters: params.query,
          options: params.options,
          data: params.body,
        )
        .then((value) => value as MyResponse<T>);
  }
}
