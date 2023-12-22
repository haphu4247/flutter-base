import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:base_flutter/base/tracking_logger/app_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'downloader.dart';
import 'notification_model.dart';

abstract class IFcmManager {
  factory IFcmManager() {
    return _instance;
  }
  IFcmManager._internal();

  Future<dynamic> initFcm({
    required FirebaseOptions options,
    required bool enableCrashlytics,
  });

  Future<String?> getFcmToken({
    required void Function(String fcmToken) onGetToken,
  });

  Future<dynamic> _showNotification({
    RemoteNotification? notification,
    String? payload,
    Map<String, dynamic>? data,
  });

  Future<NotificationDetails> _setupNotificationDetails({
    required String? remoteSound,
  });

  void _onListenMessage();

  void _onListenNotification(NotificationResponse response);

  void _onSelectNotification(dynamic data);

  //put in the place you want to handle selection on notification
  static void Function(NotificationModel model)? onSelect;
}

final _FcmManagerImpl _instance = _FcmManagerImpl();

class _FcmManagerImpl extends IFcmManager {
  _FcmManagerImpl() : super._internal();

  static const String _androidSoundID =
      'lotteria_high_importance_channel_sound';

  static const String _androidChannelName =
      'High Importance Notifications Sound';

  static const String _androidNoSoundID = 'lotteria_high_importance_channel';

  static const String _androidNoSoundChannelName =
      'High Importance Notifications';

  //add icon to Android folder: android/app/main/res/drawable
  static const String _androidIcon = 'ic_notification';

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  @override
  Future<dynamic> initFcm({
    required FirebaseOptions options,
    bool enableCrashlytics = true,
  }) {
    return Firebase.initializeApp(options: options).whenComplete(
      () async {
        _initializeFlutterNotification();
        _onListenMessage();
        if (!FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled &&
            enableCrashlytics &&
            kReleaseMode) {
          await FirebaseCrashlytics.instance
              .setCrashlyticsCollectionEnabled(enableCrashlytics);
        }

        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      },
    );
  }

  @override
  Future<String?> getFcmToken(
      {required void Function(String fcmToken) onGetToken}) {
    return FirebaseMessaging.instance.getToken().then((fcmToken) {
      if (fcmToken != null && fcmToken.isNotEmpty) {
        AppLogger.d(this, 'fcmToken: $fcmToken');
        onGetToken(fcmToken);
      }
      return null;
    });
  }

  Future<dynamic> _initializeFlutterNotification() async {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        final notificationPlugin =
            _localNotifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        if (notificationPlugin != null) {
          await Future.wait(
            [
              notificationPlugin.createNotificationChannel(
                const AndroidNotificationChannel(
                  _androidSoundID,
                  _androidChannelName,
                  importance: Importance.max,
                  sound: RawResourceAndroidNotificationSound('my_audio'),
                ),
              ),
              notificationPlugin.createNotificationChannel(
                const AndroidNotificationChannel(
                  _androidNoSoundID,
                  _androidNoSoundChannelName,
                  importance: Importance.max,
                  playSound: false,
                  enableVibration: false,
                ),
              )
            ],
          );
        }
      }

      const initializationSettingsAndroid =
          AndroidInitializationSettings(_androidIcon);

      final initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );

      final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      return _localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onListenNotification,
        onDidReceiveBackgroundNotificationResponse: _onListenNotification,
      );
    }
  }

  void launchAppFromNotification() {
    //check notification when app is opened by Notification.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _onSelectNotification(message);
      }
    });
  }

  Future<dynamic> _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    final RemoteNotification notification = RemoteNotification(
      title: title,
      body: body,
    );

    AppLogger.consoleToast(
        _FcmManagerImpl, 'onDidReceiveLocalNotification=>payload: $payload');
    return _showNotification(notification: notification, payload: payload);
  }

  static DateTime? _lastNotiTime;
  @override
  Future<dynamic> _showNotification(
      {RemoteNotification? notification,
      String? payload,
      Map<String, dynamic>? data}) async {
    if (notification == null) {
      return;
    }

    if (Platform.isAndroid) {
      /// flutter android notification does not work
      /// show in the foreground message in some case
      final notificationPlugin =
          _localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (notificationPlugin != null) {
        final permission = await notificationPlugin.areNotificationsEnabled();
        if (permission != true) {
          await notificationPlugin.requestPermission();
        }
      }
    }

    final String? remoteSound;
    if (Platform.isAndroid) {
      remoteSound = notification.android?.sound;
    } else {
      remoteSound = notification.apple?.sound?.name;
    }

    AppLogger.consoleToast(NotificationDetails, 'remoteSound:$remoteSound');

    if (_lastNotiTime != null) {
      final now = DateTime.now();
      final miliSeconds =
          now.millisecondsSinceEpoch - _lastNotiTime!.millisecondsSinceEpoch;
      if (miliSeconds < 2500) {
        return Future.delayed(
          const Duration(milliseconds: 2000),
          () {
            return _setupNotificationDetails(
                    remoteSound: remoteSound, notification: notification)
                .then((value) {
              _localNotifications
                  .show(
                hashCode,
                notification.title,
                notification.body,
                value,
                payload: payload ?? jsonEncode(data),
              )
                  .whenComplete(() {
                _lastNotiTime = DateTime.now();
              });
            });
          },
        );
      }
    }
    return _setupNotificationDetails(
            remoteSound: remoteSound, notification: notification)
        .then((value) {
      _localNotifications
          .show(
        hashCode,
        notification.title,
        notification.body,
        value,
        payload: payload ?? jsonEncode(data),
      )
          .whenComplete(() {
        _lastNotiTime = DateTime.now();
      });
    });
  }

  @override
  Future<NotificationDetails> _setupNotificationDetails(
      {required String? remoteSound, RemoteNotification? notification}) async {
    AppLogger.consoleToast(NotificationDetails, 'remoteSound: $remoteSound');
    final imgLink = notification?.android?.imageUrl;
    File? largeIconFile;
    if (imgLink != null && imgLink.isNotEmpty) {
      largeIconFile = await Downloader.downloadImageUrl(urlPath: imgLink);
    }

    if (remoteSound == null) {
      return NotificationDetails(
        android: AndroidNotificationDetails(
          _androidNoSoundID,
          _androidNoSoundChannelName,
          importance: Importance.low,
          icon: '@mipmap/ic_launcher',
          enableVibration: false,
          playSound: false,
          largeIcon: largeIconFile != null
              ? FilePathAndroidBitmap(largeIconFile.path)
              : null,
        ),
        iOS: DarwinNotificationDetails(
            presentBadge: true,
            presentSound: false,
            presentAlert: true,
            threadIdentifier: 'ria_noti',
            attachments: [
              if (largeIconFile != null)
                DarwinNotificationAttachment(largeIconFile.path)
            ]),
      );
    }
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidSoundID,
        _androidChannelName,
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        largeIcon: largeIconFile != null
            ? FilePathAndroidBitmap(largeIconFile.path)
            : null,
        sound: RawResourceAndroidNotificationSound(remoteSound),
      ),
      iOS: DarwinNotificationDetails(
          presentBadge: true,
          presentSound: true,
          presentAlert: true,
          sound: remoteSound,
          threadIdentifier: 'ria_noti',
          attachments: [
            if (largeIconFile != null)
              DarwinNotificationAttachment(largeIconFile.path)
          ]),
    );
  }

  @override
  void _onListenNotification(NotificationResponse response) {
    _onSelectNotification(response.payload);
  }

  @override
  void _onSelectNotification(dynamic data) {
    final NotificationModel model;
    if (data is RemoteMessage) {
      model = NotificationModel.fromJson(data.data);
    } else {
      model = NotificationModel.fromJson(data);
    }
    //handle event when user click on Notification
    IFcmManager.onSelect?.call(model);
  }

  //This function receive data from Push Notification when app is in Forceground or Background
  @override
  void _onListenMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        _showNotification(notification: notification, data: message.data);
      }
      _onSelectNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      _onSelectNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_onSelectNotification);
  }
}
