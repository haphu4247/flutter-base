import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_base/app_base.dart';
import 'package:base_flutter/plugin/firebase/firebase_options/firebase_options_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'downloader.dart';
import 'notification_model.dart';

part 'fcm_manager_impl.dart';

final IFcmManager _instance = _FcmManagerImpl();

abstract class IFcmManager {
  static Future<dynamic> init({
    required Env env,
    bool enableCrashlytics = false,
  }) async {
    final options = BaseFirebaseOptions(env);
    await _instance._initFcm(
      options: options.currentPlatform,
      enableCrashlytics: enableCrashlytics,
    );
  }

  static IFcmManager get instance => _instance;

  IFcmManager._internal();

  /// Initializes FCM and notification channels.
  Future<dynamic> _initFcm({
    required FirebaseOptions options,
    required bool enableCrashlytics,
  });

  Future<String?> getFcmToken({
    required void Function(String fcmToken) onGetToken,
  });

  Future<dynamic> showNotification({
    String? remoteSound,
    String? imgLink,
    required RemoteNotification notification,
    required Map<String, dynamic> data,
  });

  Future<NotificationDetails> notificationDetails({
    required String? remoteSound,
    String? imgLink,
    RemoteNotification? notification,
    required int id,
  });

  Future<dynamic> handleNotificationResponse({required RemoteMessage message});

  void _onListenMessage();

  void _onListenNotification(NotificationResponse response);

  void handleSelectNotification(dynamic data);

  //put in the place you want to handle selection on notification
  // static void Function(NotificationModel model)? onSelect;
  StreamController<NotificationModel> get onSelect;
}
