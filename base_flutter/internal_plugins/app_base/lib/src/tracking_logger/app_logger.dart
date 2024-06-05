import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class AppLogger {
  AppLogger({required bool debugMode}) {
    _kDebugMode = debugMode;
  }

  static bool _kDebugMode = true;

  static final _logger = Logger();

  static bool get isDebug => _kDebugMode;

  static void console(dynamic tag, dynamic e) {
    if (isDebug) {
      log('$tag: ==>> $e');
    }
  }

  static void d(dynamic tag, dynamic e) {
    if (isDebug) {
      _logger.d('${tag.runtimeType} : $e');
    }
  }

  static void e(dynamic tag, dynamic e) {
    if (isDebug) {
      _logger.e('${tag.runtimeType}', error: e);
    }
  }

  static void consoleToast(dynamic tag, String msg) {
    if (isDebug) {
      log('$tag: ==>> $msg');
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 14);
    }
  }

  static void onError(Object error, StackTrace stack) {
    if (isDebug) {
      _logger.e('root exception', error: error, stackTrace: stack);
    }
  }
}
