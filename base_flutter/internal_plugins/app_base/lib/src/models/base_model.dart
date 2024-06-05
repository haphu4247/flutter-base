import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  const BaseModel();

  Map<dynamic, dynamic> toJson() => {};

  @override
  List<Object?> get props => toJson().values.toList();

  @override
  String toString() => jsonEncode(toJson());
}
