import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'base_model.dart';

class MyResponse<T extends BaseModel> extends Response {
  MyResponse({required super.requestOptions});

  bool get isSucceed {
    return statusCode == 200 && data != null;
  }

  Future<List<T>> parseList(T Function(dynamic json) generator) {
    return compute(_processList, generator);
  }

  Future<T> parseObject(T Function(dynamic json) generator) {
    return compute(generator, data);
  }

  List<T> _processList(T Function(dynamic json) generator) {
    return (data as List).map((json) => generator(json)).toList();
  }
}
