import 'dart:io';

import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path_provider/path_provider.dart';

import '../models/base_model.dart';

abstract class AppTracking {
  factory AppTracking({
    required Directory? writeToDirectory,
    required bool enableCrashlytics,
  }) {
    return _AppTracking(
      writeToDirectory: writeToDirectory,
      enableCrashlytics: enableCrashlytics,
    );
  }

  AppTracking._internal();

  void writeLog<T extends BaseModel>(T model);
}

class _AppTracking extends AppTracking {
  _AppTracking({
    required this.writeToDirectory,
    required this.enableCrashlytics,
  }) : super._internal();
  final Directory? writeToDirectory;
  final bool enableCrashlytics;

  Directory? _localPath;

  @override
  void writeLog<T extends BaseModel>(T model) {
    _saveToTrackingDir(model);
    _saveToFirebase(model);
  }

  FutureOr<dynamic> _saveToTrackingDir(BaseModel model) async {
    Directory? directory = writeToDirectory;
    directory ??= await _trackingDirectory();
    if (directory != null) {
      final file = _toFile(directory);
      return file.writeAsString(model.toString());
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

  FutureOr<dynamic> _saveToFirebase(BaseModel model) async {
    if (enableCrashlytics) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        // Collection is enabled.
        FirebaseCrashlytics.instance.log(model.toString());
      }
    }
    return null;
  }

  FutureOr<Directory?> _trackingDirectory() async {
    if (_localPath != null) {
      return _localPath;
    }
    final directory = await _getDirectory();
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

  FutureOr<Directory?> _getDirectory() => getTemporaryDirectory();
}
