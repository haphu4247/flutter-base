import 'dart:convert';

import 'package:app_base/app_base.dart';

class NotificationModel extends BaseModel {
  const NotificationModel({
    this.url,
  }) : super();
  final String? url;

  factory NotificationModel.fromJson(dynamic json) {
    String? url;
    if (json is String) {
      final jsonData = jsonDecode(json);
      url = jsonData['url'] as String?;
    } else if (json is Map) {
      url = json['url'] as String?;
    }
    return NotificationModel(
      url: url,
    );
  }

}
