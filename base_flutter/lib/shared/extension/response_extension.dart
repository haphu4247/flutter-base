import 'package:base_flutter/base/models/base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../base/models/base_response.dart';
import '../../base/models/error_response.dart';
import '../utils/my_log.dart';

extension ResponseExt on Response<dynamic> {
  List<E>? checkResultList<R extends BaseResponse<R>, E extends BaseModel>(
      {required R Function(dynamic e) jsonParser,
      required E Function(dynamic e) itemParser,
      required ValueChanged<List<E>> onSuccess,
      ValueChanged<BaseResponse<dynamic>>? onError,
      VoidCallback? onCompleted,
      bool showSuccessToast = false}) {
    if (data != null) {
      final decodeBody = _parseBody();
      final parseResponse = jsonParser(decodeBody);
      if (parseResponse.isSuccess()) {
        final List<E> list = [];
        final data = parseResponse.data;
        if (data is List) {
          final parsedList = data.map(itemParser);
          list.addAll(parsedList);
        }
        onSuccess(list);
        return list;
      } else {
        _checkError(onError, errBody: decodeBody);
      }
    } else {
      //check Http status code.
      _checkError(onError, code: statusCode?.toString());
    }

    if (onCompleted != null) {
      onCompleted();
    }
    return null;
  }

  R? checkResultModel<R extends BaseResponse<R>>(
      {required R Function(dynamic e) jsonParser,
      required ValueChanged<R> onSuccess,
      ValueChanged<ErrorResponse>? onError,
      VoidCallback? onCompleted,
      bool showErrorToast = true,
      bool showSuccessToast = false}) {
    MyLogger.d(this, 'Response: ${toString()}');
    if (data != null) {
      final decodeBody = _parseBody();
      final model = jsonParser(decodeBody);
      if (model.isSuccess()) {
        onSuccess(model);
        return model;
      } else {
        _checkError(onError,
            errBody: decodeBody, resultMessage: model.resultMessage);
      }
    } else {
      //check Http status code.
      _checkError(onError, code: statusCode?.toString());
    }

    if (onCompleted != null) {
      onCompleted();
    }
    return null;
  }

  dynamic _parseBody() {
    //parse body if neeed
    return data;
  }

  void _checkError(
    ValueChanged<ErrorResponse>? onError, {
    dynamic errBody,
    String? code,
    String? resultMessage,
  }) {
    // final err = ErrorResponse();

    // if (errBody != null) {
    //   err.parsedJson(errBody);
    // } else {
    //   err.resultCode = resultCode;
    //   err.resultMessage = resultMessage;
    // }

    // if (onError != null) {
    //   onError(err);
    // }
  }
}
