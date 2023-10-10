import 'dart:io';

import 'package:base_flutter/base/models/base_model.dart';
import 'package:base_flutter/plugin/permission_plugin.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

abstract class AppTracking {
  factory AppTracking({
    required bool enableWriteToDownload,
    required bool enableWriteToFirebaseLog,
  }) {
    return _AppTracking(
      enableWriteToDownload: enableWriteToDownload,
      enableWriteToFirebaseLog: enableWriteToFirebaseLog,
    );
  }

  AppTracking._internal();

  void writeLog<T extends BaseModel>(T model);

  Future<bool> requestPermissionOnInit();
}

class _AppTracking extends AppTracking {
  _AppTracking({
    required bool enableWriteToDownload,
    required bool enableWriteToFirebaseLog,
  }) : super._internal() {
    _enableWriteToDownload = enableWriteToDownload;
    _enableWriteToFirebaseLog = enableWriteToFirebaseLog;
    FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(enableWriteToFirebaseLog);
  }
  late final bool _enableWriteToDownload;
  late final bool _enableWriteToFirebaseLog;

  Directory? _localPath;

  @override
  void writeLog<T extends BaseModel>(T model) {
    _saveToTrackingDir(model);
    _saveToFirebase(model);
  }

  Future<dynamic> _saveToTrackingDir(BaseModel model) async {
    if (_enableWriteToDownload) {
      return _trackingDirectory().then((directory) {
        if (directory != null) {
          final file = _toFile(directory);
          file.writeAsString(model.toString());
        }
      });
    }
    return null;
  }

  File _toFile(Directory directory) {
    final now = DateTime.now();
    final fileName =
        '${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}.json';
    final file = '${directory.path}${Platform.pathSeparator}$fileName';
    return File(file);
  }

  Future<dynamic> _saveToFirebase(BaseModel model) async {
    if (_enableWriteToFirebaseLog) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        // Collection is enabled.
        FirebaseCrashlytics.instance.log(model.toString());
      }
    }
    return null;
  }

  Future<Directory?> _trackingDirectory() async {
    if (_localPath != null) {
      return _localPath;
    }
    final directory = await _getPlatformDirectory();
    if (directory != null) {
      final trackingPath =
          '${directory.path}${Platform.pathSeparator}base-tracking';
      final savedDir = Directory(trackingPath);
      final bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        _localPath = await savedDir.create();
      } else {
        _localPath = savedDir;
      }
      return _localPath;
    }
    return null;
  }

  Future<Directory?> _getPlatformDirectory() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return getExternalStorageDirectory();
    } else {
      return getDownloadsDirectory();
    }
  }

  @override
  Future<bool> requestPermissionOnInit() {
    if (_enableWriteToDownload) {
      return AppPermission().requestSaveFile();
    }
    return Future.value(false);
  }
}
