import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  const BaseModel({this.data});

  final dynamic data;

  Map<dynamic, dynamic> toJson();

  @override
  List<Object?> get props => toJson().values.toList();

  @override
  String toString() => jsonEncode(toJson());
}
