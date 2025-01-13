import 'package:app_base/app_base.dart';
import 'package:intl/intl.dart';

enum AppDateFormat {
  yyyymmdd,
  yyyyMMdd,
  ddMMyyyy,
  EEE,
  MMMM,
  HHmm;

  DateFormat get format {
    return DateFormat(_customPattern);
  }

  String get _customPattern {
    switch (this) {
      case AppDateFormat.ddMMyyyy:
        return 'dd/MM/yyyy';
      case AppDateFormat.yyyyMMdd:
        return 'yyyy/MM/dd';
      case AppDateFormat.HHmm:
        return 'HH:mm';
      default:
        return name;
    }
  }
}

class DateTimeUtils {
  static String formatDate(DateTime date, {required AppDateFormat type}) {
    final String dateString = type.format.format(date);
    return dateString;
  }

  static String formatDateyyyyMMdd(DateTime date) {
    return formatDate(date, type: AppDateFormat.yyyyMMdd);
  }

  static DateTime? toDate(String datetime,
      {AppDateFormat format = AppDateFormat.ddMMyyyy}) {
    try {
      return format.format.parse(datetime);
    } catch (e) {
      AppLogger.console(DateTimeUtils, e);
      //try parse date time string again,
      //return null if #datetime is not date time format.
      return DateTime.tryParse(datetime);
    }
  }

  static DateTime fromMilliSeconds(int? millisecondsSinceEpoch) {
    if (millisecondsSinceEpoch == null) {
      return DateTime.now();
    }
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  static String formatDateFromMilliSeconds(int? millisecondsSinceEpoch) {
    final date = fromMilliSeconds(millisecondsSinceEpoch);
    return formatDateyyyyMMdd(date);
  }
}
