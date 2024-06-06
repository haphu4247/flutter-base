import 'package:dio/dio.dart';

class BaseException implements Exception {
  final String message;
  final int? code;
  const BaseException({this.message = 'Unknown exception!', this.code});

  @override
  String toString() => message;
}

extension DioExceptionExt on DioException {
  BaseException get customException {
    return BaseException();
  }
}
