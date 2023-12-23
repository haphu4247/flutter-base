import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/local_repositories/local_repository.dart';

abstract class AppPermissionPlugin {
  factory AppPermissionPlugin() {
    return _singleton;
  }

  AppPermissionPlugin._internal();

  Future<Position> requestUserPosition();

  Future<bool> requestSaveFile();

  Future<bool> requestSavePhotoToGalleryPermission();

  Future<dynamic> requestNotificationPermission(LocalRepository local);
}

final _MyAppPermission _singleton = _MyAppPermission._();

class _MyAppPermission extends AppPermissionPlugin {
  _MyAppPermission._() : super._internal();

  @override
  Future<Position> requestUserPosition() async {
    // bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition();
  }

  @override
  Future<bool> requestSavePhotoToGalleryPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        /// use [Permissions.storage.status]
        final storage = await Permission.storage.status;
        if (storage != PermissionStatus.granted) {
          final result = await Permission.storage.request();
          if (result == PermissionStatus.granted) {
            return true;
          } else if (result == PermissionStatus.permanentlyDenied ||
              result == PermissionStatus.denied) {
            //Navigate to app setting.
            final result = await openAppSettings();
            return result;
          }
        } else {
          return true;
        }
      } else {
        /// use [Permissions.photos.status]
        final photos = await Permission.photos.status;
        if (photos != PermissionStatus.granted) {
          final result = await Permission.photos.request();
          if (result == PermissionStatus.granted) {
            return true;
          } else if (result == PermissionStatus.permanentlyDenied ||
              result == PermissionStatus.denied) {
            //Navigate to app setting.
            final result = await openAppSettings();
            return result;
          }
        } else {
          return true;
        }
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  Future<dynamic> requestNotificationPermission(LocalRepository local) {
    return local.getNotificationPermission().then((value) {
      if (value == null || value.isEmpty) {
        Permission.notification.isGranted.then(
          (value) {
            if (value == false) {
              Permission.notification.request().then(
                (value) {
                  return local.saveNotificationPermission();
                },
              );
            }
          },
        );
      }
    });
  }

  @override
  Future<bool> requestSaveFile() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
  
}
