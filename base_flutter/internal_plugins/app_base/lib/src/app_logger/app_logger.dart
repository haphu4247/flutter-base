import 'dart:developer';
import 'package:app_base/app_base.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  // static late final Env env;
  static final bool isDebug = kDebugMode;
  static late final Talker _talker;

  /// Call this once at app startup
  static void init({required Env env}) {
    // AppLogger.env = env;
    final enable = env == Env.dev || env == Env.staging || isDebug;
    _talker = Talker(
      settings: TalkerSettings(
        /// You can enable/disable all talker processes with this field
        enabled: enable,
        useHistory: true,
        useConsoleLogs: true,
      ),

      /// Setup your implementation of logger
      logger: TalkerLogger(),
    );
  }

  static void gotoTalker(BuildContext context) {
    if (_talker.settings.enabled == true) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TalkerScreen(
          talker: _talker,
        ),
      ));
    }
  }

  static void printDebugLog(Dio dio) {
    if (_talker.settings.enabled) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker: _talker,
          settings: const TalkerDioLoggerSettings(),
        ),
      );
    }
  }

  static void console(Object? tag, Object? e) {
    if (isDebug) {
      log('${tag.toString()}: ==>> $e');
    }
  }

  static void d(Object? tag, Object? e) {
    if (isDebug) {
      _talker.debug('${tag.toString()} : $e');
    }
  }

  static void e(Object? tag, Object? e) {
    if (isDebug) {
      _talker.error(tag.toString(), e);
    }
  }

  static void consoleToast(Object? tag, String msg) {
    if (isDebug) {
      log('${tag.toString()}: ==>> $msg');
    }
  }

  static void onError(Object? error, StackTrace? stack) {
    if (isDebug && error != null) {
      _talker.handle(error, stack, 'root exception');
    }
  }

  static void recordError(Object? error, StackTrace? stack) {
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  }
}
