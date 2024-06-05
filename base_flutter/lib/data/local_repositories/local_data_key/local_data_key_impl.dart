import 'package:app_base/app_base.dart';

enum LocalDataKey {
  clear,
  sAppLocale,
  sAppCurrency,
  bFirstTimeOpenApp,
  sThemes,
  login,
  showHomePopup,
  fcmToken,
  requestNotificationPermission;

  BaseLocalData get instance => BaseLocalData.instance(this);
}
