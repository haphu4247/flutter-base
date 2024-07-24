// ignore_for_file: prefer_conditional_assignment, prefer_single_quotes

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio_http_cache/src/core/config.dart';
import 'package:dio_http_cache/src/core/manager.dart';
import 'package:dio_http_cache/src/core/obj.dart';

enum DioCacheKey {
  tryCache('dio_cache_try_cache'),
  maxAge('dio_cache_max_age'),
  maxStale('dio_cache_max_stale'),
  primaryKey('dio_cache_primary_key'),
  subKey('dio_cache_sub_key'),
  forceRefresh('dio_cache_force_refresh'),
  headerKeyDataSource('dio_cache_header_key_data_source');

  const DioCacheKey(this.name);
  final String name;
}

// const DIO_CACHE_KEY_TRY_CACHE = 'dio_cache_try_cache';
// const DIO_CACHE_KEY_MAX_AGE = 'dio_cache_max_age';
// const DIO_CACHE_KEY_MAX_STALE = 'dio_cache_max_stale';
// const DIO_CACHE_KEY_PRIMARY_KEY = 'dio_cache_primary_key';
// const DIO_CACHE_KEY_SUB_KEY = 'dio_cache_sub_key';
// const DIO_CACHE_KEY_FORCE_REFRESH = 'dio_cache_force_refresh';
// const DIO_CACHE_HEADER_KEY_DATA_SOURCE = 'dio_cache_header_key_data_source';

class DioCacheManager<T> {
  late CacheManager<T> _manager;
  InterceptorsWrapper? _interceptor;
  late String? _baseUrl;
  late String _defaultRequestMethod;

  CacheEncryption<T>? _cacheEncryption;

  DioCacheManager(CacheConfig<T> config) {
    _manager = CacheManager(config);
    _cacheEncryption = config.encryption;
    _baseUrl = config.baseUrl;
    _defaultRequestMethod = config.defaultRequestMethod;
  }

  /// interceptor for http cache.
  InterceptorsWrapper get interceptor {
    if (null == _interceptor) {
      _interceptor = InterceptorsWrapper(
          onRequest: _onRequest, onResponse: _onResponse, onError: _onError);
    }
    return _interceptor!;
  }

  Future<void> _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if ((options.extra[DioCacheKey.tryCache.name] ?? false) != true) {
      return handler.next(options);
    }
    if (true == options.extra[DioCacheKey.forceRefresh.name]) {
      return handler.next(options);
    }
    final responseDataFromCache = await _pullFromCacheBeforeMaxAge(options);
    if (null != responseDataFromCache) {
      return handler.resolve(
          _buildResponse(
              responseDataFromCache, responseDataFromCache.statusCode, options),
          true);
    }
    return handler.next(options);
  }

  Future<void> _onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if ((response.requestOptions.extra[DioCacheKey.tryCache.name] ?? false) ==
            true &&
        response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      await _pushToCache(response);
    }
    return handler.next(response);
  }

  Future<void> _onError(DioError e, ErrorInterceptorHandler handler) async {
    if ((e.requestOptions.extra[DioCacheKey.tryCache.name] ?? false) == true) {
      final responseDataFromCache =
          await _pullFromCacheBeforeMaxStale(e.requestOptions);
      if (null != responseDataFromCache) {
        final response = _buildResponse(responseDataFromCache,
            responseDataFromCache.statusCode, e.requestOptions);

        return handler.resolve(response);
      }
    }
    return handler.next(e);
  }

  Response<dynamic> _buildResponse(
      CacheObj obj, int? statusCode, RequestOptions options) {
    Headers? headers;
    final _bytes = obj.headers;
    if (null != _bytes) {
      final _parsedBytes = jsonDecode(utf8.decode(_bytes)) as Map?;
      if (_parsedBytes != null) {
        headers = Headers.fromMap(
          Map<String, List<dynamic>>.from(_parsedBytes).map(
            (k, v) => MapEntry(k, List<String>.from(v)),
          ),
        );
      }
    }
    if (null == headers) {
      headers = Headers();
      options.headers.forEach((k, v) => headers!.add(k, '$v'));
    }
    // add flag
    headers.add(DioCacheKey.headerKeyDataSource.name, 'from_cache');
    dynamic data = obj.content;
    if (options.responseType != ResponseType.bytes) {
      if (data is List<int>) {
        data = jsonDecode(utf8.decode(data));
      }
    }
    return Response(
        data: data,
        headers: headers,
        requestOptions: options.copyWith(
            extra: options.extra..remove(DioCacheKey.tryCache.name)),
        statusCode: statusCode ?? 200);
  }

  Future<CacheObj?> _pullFromCacheBeforeMaxAge(RequestOptions options) {
    return _manager.pullFromCacheBeforeMaxAge(
        _getPrimaryKeyFromOptions(options),
        subKey: _getSubKeyFromOptions(options));
  }

  Future<CacheObj?> _pullFromCacheBeforeMaxStale(RequestOptions options) {
    return _manager.pullFromCacheBeforeMaxStale(
        _getPrimaryKeyFromOptions(options),
        subKey: _getSubKeyFromOptions(options));
  }

  Future<bool> _pushToCache(Response<dynamic> response) {
    final RequestOptions options = response.requestOptions;
    var maxAge = options.extra[DioCacheKey.maxAge.name] as Duration?;
    var maxStale = options.extra[DioCacheKey.maxStale.name] as Duration?;
    if (null == maxAge) {
      _tryParseHead(response, maxStale, (_maxAge, _maxStale) {
        maxAge = _maxAge;
        maxStale = _maxStale;
      });
    }
    List<int>? data;
    if (options.responseType == ResponseType.bytes) {
      data = response.data as List<int>;
    } else {
      data = utf8.encode(jsonEncode(response.data));
    }
    final obj = CacheObj<T>(
      _getPrimaryKeyFromOptions(options),
      data,
      subKey: _getSubKeyFromOptions(options),
      maxAge: maxAge,
      maxStale: maxStale,
      statusCode: response.statusCode,
      headers: utf8.encode(jsonEncode(response.headers.map)),
      encryption: _cacheEncryption,
    );
    return _manager.pushToCache(obj);
  }

  // try to get maxAge and maxStale from http headers
  void _tryParseHead(Response<dynamic> response, Duration? maxStale,
      void Function(Duration?, Duration?) callback) {
    Duration? _maxAge;
    final cacheControl = response.headers.value(HttpHeaders.cacheControlHeader);
    if (null != cacheControl) {
      // try to get maxAge and maxStale from cacheControl
      Map<String, String?> parameters;
      try {
        parameters = HeaderValue.parse(
                '${HttpHeaders.cacheControlHeader}: $cacheControl',
                parameterSeparator: ',',
                valueSeparator: '=')
            .parameters;
        _maxAge = _tryGetDurationFromMap(parameters, 's-maxage');
        if (null == _maxAge) {
          _maxAge = _tryGetDurationFromMap(parameters, 'max-age');
        }
        // if maxStale has valued, don't get max-stale anymore.
        if (null == maxStale) {
          maxStale = _tryGetDurationFromMap(parameters, 'max-stale');
        }
      } catch (e) {
        print(e);
      }
    } else {
      // try to get maxAge from expires
      final expires = response.headers.value(HttpHeaders.expiresHeader);
      if (null != expires && expires.length > 4) {
        DateTime? endTime;
        try {
          endTime = HttpDate.parse(expires).toLocal();
        } catch (e) {
          print(e);
        }
        if (null != endTime && endTime.compareTo(DateTime.now()) >= 0) {
          _maxAge = endTime.difference(DateTime.now());
        }
      }
    }
    callback(_maxAge, maxStale);
  }

  Duration? _tryGetDurationFromMap(
      Map<String, String?> parameters, String key) {
    if (parameters.containsKey(key)) {
      final value = int.tryParse(parameters[key]!);
      if (null != value && value >= 0) {
        return Duration(seconds: value);
      }
    }
    return null;
  }

  String _getPrimaryKeyFromOptions(RequestOptions options) {
    final primaryKey = options.extra.containsKey(DioCacheKey.primaryKey.name)
        ? options.extra[DioCacheKey.primaryKey.name]
        : _getPrimaryKeyFromUri(options.uri);

    return '${_getRequestMethod(options.method)}-$primaryKey';
  }

  String _getRequestMethod(String? requestMethod) {
    if (null != requestMethod && requestMethod.isNotEmpty) {
      return requestMethod.toUpperCase();
    }
    return _defaultRequestMethod.toUpperCase();
  }

  String? _getSubKeyFromOptions(RequestOptions options) {
    return options.extra.containsKey(DioCacheKey.subKey.name)
        ? options.extra[DioCacheKey.subKey.name].toString()
        : _getSubKeyFromUri(options.uri, data: options.data);
  }

  String _getPrimaryKeyFromUri(Uri uri) => "${uri.host}${uri.path}";

  String _getSubKeyFromUri(Uri uri, {dynamic data}) =>
      '${data?.toString()}_${uri.query}';

  /// delete local cache by primaryKey and optional subKey
  Future<bool> delete(String primaryKey,
          {String? requestMethod, String? subKey}) =>
      _manager.delete('${_getRequestMethod(requestMethod)}-$primaryKey',
          subKey: subKey);

  /// no matter what subKey is, delete local cache if primary matched.
  Future<bool> deleteByPrimaryKeyWithUri(Uri uri, {String? requestMethod}) =>
      delete(_getPrimaryKeyFromUri(uri), requestMethod: requestMethod);

  Future<bool> deleteByPrimaryKey(String path, {String? requestMethod}) =>
      deleteByPrimaryKeyWithUri(_getUriByPath(_baseUrl, path),
          requestMethod: requestMethod);

  /// delete local cache when both primaryKey and subKey matched.
  Future<bool> deleteByPrimaryKeyAndSubKeyWithUri(Uri uri,
          {String? requestMethod, String? subKey, dynamic data}) =>
      delete(_getPrimaryKeyFromUri(uri),
          requestMethod: requestMethod,
          subKey: subKey ?? _getSubKeyFromUri(uri, data: data));

  Future<bool> deleteByPrimaryKeyAndSubKey(String path,
          {String? requestMethod,
          Map<String, dynamic>? queryParameters,
          String? subKey,
          dynamic data}) =>
      deleteByPrimaryKeyAndSubKeyWithUri(
          _getUriByPath(_baseUrl, path,
              data: data, queryParameters: queryParameters),
          requestMethod: requestMethod,
          subKey: subKey,
          data: data);

  /// clear all expired cache.
  Future<bool> clearExpired() => _manager.clearExpired();

  /// empty local cache.
  Future<bool> clearAll() => _manager.clearAll();

  Uri _getUriByPath(String? baseUrl, String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) {
    if (!path.startsWith(RegExp('https?:'))) {
      assert(baseUrl != null && baseUrl.isNotEmpty);
    }
    return RequestOptions(
            baseUrl: baseUrl,
            path: path,
            data: data,
            queryParameters: queryParameters)
        .uri;
  }
}
