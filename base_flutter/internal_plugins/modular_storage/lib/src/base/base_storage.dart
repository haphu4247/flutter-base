import 'package:modular_storage/src/impl/shared_preferences_storage.dart';
import 'package:modular_storage/src/models/storage_model.dart';

abstract class BaseStorage {
  factory BaseStorage.instance() {
    return SharedPreferencesStorage();
  }

  Future<bool> write<E extends Enum>(E key, String value);
  Future<String?> read<E extends Enum>(E key);

  Future<bool> writeObj<E extends Enum, T extends StorageModel>(E key, T obj);
  Future<T?> readObj<E extends Enum, T extends StorageModel>(
      E key, T Function(dynamic e) parser);

  Future<bool> writeListObj<E extends Enum, T extends StorageModel>(
      E key, List<T> obj);
  Future<Iterable<T>?> readListObj<E extends Enum, T extends StorageModel>(
      E key, T Function(dynamic e) parser);

  Future<bool> delete<E extends Enum>(E key);

  Future<bool> containsKey<E extends Enum>(E key);

  Future<bool> clear();
}
