import 'package:app_base/app_base.dart';
import 'package:app_base/src/storage/impl/shared_preferences_storage.dart';

abstract class BaseStorage {
  factory BaseStorage.instance() {
    return SharedPreferencesStorage();
  }

  Future<bool> write<E extends Enum>(E key, String value);

  Future<String?> read<E extends Enum>(E key);

  Future<bool> writeObj<E extends Enum, T extends BaseModel>(E key, T obj);

  Future<T?> readObj<E extends Enum, T extends BaseModel>(
      E key, T Function(Map<String, dynamic> e) parser);

  Future<bool> writeListObj<E extends Enum, T extends BaseModel>(
      E key, List<T> obj);
  Future<Iterable<T>?> readListObj<E extends Enum, T extends BaseModel>(
      E key, T Function(dynamic e) parser);

  Future<bool> delete<E extends Enum>(E key);

  Future<bool> containsKey<E extends Enum>(E key);

  Future<bool> clear();
}
