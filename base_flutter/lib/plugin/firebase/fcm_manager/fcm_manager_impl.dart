part of 'fcm_manager.dart';

const String _androidSoundID = 'high_importance_channel_sound';

const String _androidChannelName = 'High Importance Notifications Sound';

const String _androidNoSoundID = 'high_importance_channel';

const String _androidNoSoundChannelName = 'High Importance Notifications';

//add icon to Android folder: android/app/main/res/drawable
const String _androidIcon = 'ic_notification';

class _FcmManagerImpl extends IFcmManager {
  _FcmManagerImpl() : super._internal();

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final _notificationStream = StreamController<NotificationModel>.broadcast();
  @override
  StreamController<NotificationModel> get onSelect {
    return _notificationStream;
  }

  @override
  Future<dynamic> _initFcm({
    required FirebaseOptions options,
    required bool enableCrashlytics,
  }) async {
    try {
      await Firebase.initializeApp(options: options);
      _initNotification();
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
    } catch (e, stack) {
      AppLogger.onError(e, stack);
    }
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
    }).onError(
      (error, stackTrace) async {
        AppLogger.onError(error, stackTrace);
      },
    );
  }

  Future<dynamic> _initNotification() async {
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

      const initializationSettingsIOS = DarwinInitializationSettings();

      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      return _localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onNotificationResponse,
      );
    }
  }

  static void onNotificationResponse(NotificationResponse response) {
    _instance.handleSelectNotification(response);
  }

  void launchAppFromNotification() {
    //check notification when app is opened by Notification.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        handleSelectNotification(message);
      }
    });
  }

  static DateTime? _lastNotificationTime;

  @override
  Future<dynamic> handleNotificationResponse(
      {required RemoteMessage message}) async {
    try {
      final notification = message.notification;
      if (notification == null) {
        return;
      }

      final data = message.data;

      if (Platform.isAndroid) {
        /// flutter android notification does not work
        /// show in the foreground message in some case
        final notificationPlugin =
            _localNotifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        if (notificationPlugin != null) {
          final permission = await notificationPlugin.areNotificationsEnabled();
          if (permission != true) {
            await notificationPlugin.requestNotificationsPermission();
          }
        }
      }

      final String? remoteSound;
      final String? imgLink;
      if (Platform.isAndroid) {
        remoteSound = notification.android?.sound;
        imgLink = notification.android?.imageUrl;
      } else {
        remoteSound = notification.apple?.sound?.name;
        imgLink = notification.apple?.imageUrl;
      }
      if (imgLink != null && imgLink.isNotEmpty) {
        data.putIfAbsent('image', () => imgLink);
      }

      AppLogger.consoleToast(NotificationDetails, 'remoteSound:$remoteSound');

      if (_shouldThrottleNotification()) {
        return Future.delayed(
          const Duration(milliseconds: 2000),
          () => showNotification(
            remoteSound: remoteSound,
            imgLink: imgLink,
            notification: notification,
            data: data,
          ),
        );
      }

      return showNotification(
        remoteSound: remoteSound,
        imgLink: imgLink,
        notification: notification,
        data: data,
      );
    } catch (e, stack) {
      AppLogger.onError(e, stack);
    }
  }

  @override
  Future<dynamic> showNotification({
    String? remoteSound,
    String? imgLink,
    required RemoteNotification notification,
    required Map<String, dynamic> data,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.remainder(10000);
    AppLogger.consoleToast(
        NotificationDetails, 'remoteSound:$remoteSound id: $id');
    return notificationDetails(
      remoteSound: remoteSound,
      imgLink: imgLink,
      notification: notification,
      id: id,
    ).then((value) {
      return _localNotifications
          .show(
        // unique ID for each notification
        id,
        notification.title,
        notification.body,
        value,
        payload: json.encode(data),
      )
          .whenComplete(() {
        _lastNotificationTime = DateTime.now();
      });
    });
  }

  @override
  Future<NotificationDetails> notificationDetails({
    required String? remoteSound,
    String? imgLink,
    RemoteNotification? notification,
    required int id,
  }) async {
    AppLogger.consoleToast(NotificationDetails, 'remoteSound: $remoteSound');
    final imgLink = notification?.android?.imageUrl;
    File? largeIconFile;
    const threadIdentifier = 'ria_notification';
    if (imgLink != null && imgLink.isNotEmpty) {
      largeIconFile = await Downloader.downloadImageUrl(
          urlPath: imgLink, name: threadIdentifier);
    }

    if (remoteSound == null) {
      return NotificationDetails(
        android: AndroidNotificationDetails(
            _androidNoSoundID, _androidNoSoundChannelName,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            playSound: false,
            largeIcon: largeIconFile != null
                ? FilePathAndroidBitmap(largeIconFile.path)
                : null,
            visibility: NotificationVisibility.public),
        iOS: DarwinNotificationDetails(
          presentBadge: true,
          presentSound: false,
          presentAlert: true,
          threadIdentifier: threadIdentifier,
          attachments: [
            if (largeIconFile != null)
              DarwinNotificationAttachment(
                largeIconFile.path,
                identifier: threadIdentifier,
                hideThumbnail: false,
              )
          ],
        ),
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
        visibility: NotificationVisibility.public,
        sound: RawResourceAndroidNotificationSound(remoteSound),
      ),
      iOS: DarwinNotificationDetails(
        presentBadge: true,
        presentSound: true,
        presentAlert: true,
        sound: remoteSound,
        threadIdentifier: threadIdentifier,
        attachments: [
          if (largeIconFile != null)
            DarwinNotificationAttachment(
              largeIconFile.path,
              identifier: threadIdentifier,
              hideThumbnail: false,
            )
        ],
      ),
    );
  }

  @override
  void handleSelectNotification(dynamic data) {
    final NotificationModel model;
    if (data is RemoteMessage) {
      model = NotificationModel.fromJson(data.data);
    } else if (data is NotificationResponse) {
      model = NotificationModel.fromJson(data.data);
    } else {
      model = NotificationModel.fromJson(data);
    }
    //handle event when user click on Notification
    if (_notificationStream.hasListener) {
      _notificationStream.add(model);
    }
  }

  //This function receive data from Push Notification when app is in Foreground or Background
  @override
  void _onListenMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleNotificationResponse(message: message);
      handleSelectNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      handleSelectNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(handleSelectNotification);
  }

  bool _shouldThrottleNotification() {
    if (_lastNotificationTime == null) {
      return false;
    }
    final now = DateTime.now();
    final diff = now.millisecondsSinceEpoch -
        _lastNotificationTime!.millisecondsSinceEpoch;
    return diff < 2500;
  }

  void dispose() {
    _notificationStream.close();
  }
}
