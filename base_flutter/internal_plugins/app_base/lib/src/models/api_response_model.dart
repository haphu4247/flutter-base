import 'package:app_base/app_base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// import 'base_model.dart';

class ApiResponseModel extends Response {
  ApiResponseModel({
    required super.requestOptions,
    super.data,
    super.statusCode,
  });

  bool get isSuccess => statusCode == 200 && data != null;

  Future<List<E>> parseList<E extends BaseModel>(E Function(dynamic json) parser) {
    return compute((message) {
      if (message is List) {
        return message.map<E>((json) => parser(json)).toList();
      }
      return [];
    }, data);
  }

  Future<E> parseObject<E extends BaseModel>(E Function(dynamic json) parser) {
    return compute((message) {
      return parser(message);
    }, data);
  }
}
