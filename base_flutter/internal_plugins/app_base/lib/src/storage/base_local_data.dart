import 'dart:core';
import 'package:app_base/app_base.dart';
import 'package:app_base/src/storage/base_local_data_impl.dart';

abstract class BaseLocalData<E extends Enum> {
  const BaseLocalData(this._type);

  factory BaseLocalData.instance(E type) {
    return BaseLocalDataImpl(type, type.name);
  }

  final E _type;

  Future<bool> remove();

  Future<bool> setBool(bool value);

  Future<bool?> getBool();

  Future<bool> setInt(int value);

  Future<int?> getInt();

  Future<bool> setString(String value);

  Future<String?> getString();

  Future<bool> saveObj<T extends BaseModel>(T obj);

  Future<T?> getObj<T extends BaseModel>(T Function(dynamic e) parser);

  Future<bool> saveListObj<T extends BaseModel>(List<T> obj);

  Future<List<T>?> getListObj<T extends BaseModel>(
      T Function(dynamic e) parser);

  Future<bool> clearAll();
}
