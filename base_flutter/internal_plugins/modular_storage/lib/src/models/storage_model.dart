import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class StorageModel extends Equatable {
  const StorageModel();

  Map<dynamic, dynamic> toJson() => {};

  @override
  List<Object?> get props => toJson().values.toList();

  @override
  String toString() => jsonEncode(toJson());
}
