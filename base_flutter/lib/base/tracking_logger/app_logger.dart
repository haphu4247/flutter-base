import 'dart:developer';

import 'package:base_flutter/app/app_config.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../../flavour/flavour.dart';

class AppLogger {
  static final _logger = Logger();

  AppLogger._internal();

  static bool get isDebug => kDebugMode;

  static void console(dynamic tag, dynamic e) {
    if (kDebugMode) {
      log('$tag: ==>> $e');
    }
  }

  static void d(dynamic tag, dynamic e) {
    if (kDebugMode) {
      _logger.d('${tag.runtimeType} : $e');
    }
  }

  static void e(dynamic tag, dynamic e) {
    if (kDebugMode) {
      _logger.e('${tag.runtimeType}', error: e);
    }
  }

  static void consoleToast(dynamic tag, String msg) {
    if (kDebugMode ||
        DIConfig().getIt.get<IAppConfig>().config.env != Flavour.prod) {
      log('$tag: ==>> $msg');
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14);
    }
  }

  static void onError(Object error, StackTrace stack) {
    if (kDebugMode) {
      _logger.e('root exception', error: error, stackTrace: stack);
    }
  }
}
