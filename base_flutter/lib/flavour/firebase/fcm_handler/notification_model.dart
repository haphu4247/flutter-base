import 'dart:convert';

import 'package:base_flutter/base/models/base_model.dart';

class NotificationModel extends BaseModel {
  const NotificationModel({
    this.url,
    required dynamic payload,
  }) : super(data: payload);
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
      payload: json,
    );
  }

  @override
  Map<dynamic, dynamic> toJson() {
    return {'Url': url};
  }
}
