import 'package:dio/dio.dart';

import 'base_api_setup.dart';

abstract class BaseParams {
  String get url;
  HTTPMethod get method;
  dynamic get body;
  Map<String, String>? get headers;
  Map<String, dynamic>? get query;
  String? get contentType;
  Options get options;
  factory BaseParams(
      {String? appendPath,
      required BaseApiSetup apiSetup,
      dynamic bodyParams,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headerParams}) {
    return _BaseParamsImpl(
      apiSetup: apiSetup,
      appendPath: appendPath,
      bodyParams: bodyParams,
      queryParams: queryParams,
      headerParams: headerParams,
    );
  }

  const BaseParams._internal();
}

class _BaseParamsImpl extends BaseParams {
  final String? appendPath;
  final BaseApiSetup apiSetup;
  final dynamic bodyParams;
  final Map<String, dynamic>? queryParams;
  final Map<String, String>? headerParams;
  final String type;

  _BaseParamsImpl({
    required this.apiSetup,
    this.appendPath,
    this.bodyParams,
    this.queryParams,
    this.headerParams,
    this.type = '',
  }) : super._internal();

  @override
  String get url => apiSetup.getPath(appendPath);

  @override
  HTTPMethod get method => apiSetup.method;

  @override
  dynamic get body => bodyParams;

  @override
  Map<String, String>? get headers => headerParams;

  @override
  Map<String, dynamic>? get query => queryParams;

  @override
  String? get contentType => type;

  @override
  Options get options => Options(
      method: method.name,
      contentType: contentType,
      headers: headers,
      responseType: ResponseType.json);

  //when encoding params.
  String _encodeQueryParameters(Map<dynamic, dynamic> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent('${e.key}')}=${Uri.encodeComponent('${e.value}')}')
        .join('&');
  }

  // ignore: unused_element
  String _queryParameters(Map<dynamic, dynamic> params) {
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}
