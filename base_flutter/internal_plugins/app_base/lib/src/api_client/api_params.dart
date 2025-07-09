import 'package:app_base/app_base.dart';
import 'package:dio/dio.dart';

enum HttpMethod { get, post, delete, put, patch }

class ApiParams {
  final String path;
  final Object? data;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  final String? token;
  final HttpMethod method;
  Options get options => _toOptions();

  const ApiParams({
    required this.path,
    required this.method,
    this.data,
    this.queryParameters,
    this.headers,
    this.token,
  });

  ApiParams copyWith({
    String? path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? token,
  }) {
    return ApiParams(
      path: path ?? this.path,
      method: method,
      data: data ?? this.data,
      queryParameters: queryParameters ?? this.queryParameters,
      headers: headers ?? this.headers,
      token: token ?? this.token,
    );
  }

  Options _toOptions() {
    return Options(
      method: method.name,
      headers: getHeaders(),
    );
  }

  ApiResponseModel handleError(Object? error) {
    if (error is DioException) {
      return ApiResponseModel(
        requestOptions: error.requestOptions,
        data: error.response?.data,
        statusCode: error.response?.statusCode,
      );
    }
    return ApiResponseModel(
      requestOptions: RequestOptions(
        path: path,
        method: method.name,
        data: data,
      ),
      data: error,
      statusCode: 500,
    );
  }

  Map<String, dynamic>? getHeaders() {
    if (token == null || token!.isEmpty) {
      return headers;
    }
    if (headers != null && headers!.isNotEmpty) {
      headers!.putIfAbsent(
        'authorization',
        () => 'Bearer $token',
      );
      return headers;
    }
    return {'authorization': 'Bearer $token', 'accept': 'application/json'};
  }
}
