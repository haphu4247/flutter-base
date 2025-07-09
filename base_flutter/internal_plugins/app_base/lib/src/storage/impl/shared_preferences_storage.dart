import 'dart:convert';

import 'package:app_base/app_base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/base_storage.dart';
import '../crypto/secure_preferences.dart';

class SharedPreferencesStorage implements BaseStorage {
  late SharedPreferences _pref;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await SharedPreferences.getInstance().then((value) {
        _initialized = true;
        _pref = value;
        return _pref;
      });
    }
  }

  @override
  Future<String?> read<E extends Enum>(E key) async {
    await _ensureInitialized();
    return SecurePreferences.instance.getDecryptedValue(key, _pref).onError(
      (error, stackTrace) {
        return null;
      },
    );
  }

  @override
  Future<bool> write<E extends Enum>(E key, String value) async {
    await _ensureInitialized();
    return SecurePreferences.instance
        .setEncryptedValue(key, value, _pref)
        .onError(
      (error, stackTrace) {
        return false;
      },
    );
  }

  @override
  Future<T?> readObj<E extends Enum, T extends BaseModel>(
      E key, T Function(Map<String, dynamic> e) parser) async {
    await _ensureInitialized();
    return SecurePreferences.instance
        .getDecryptedValue(key, _pref)
        .then((source) {
      if (source != null) {
        final Map<String, dynamic> json = jsonDecode(source);
        final obj = parser(json);
        return obj;
      }
      return null;
    }).onError(
      (error, stackTrace) {
        return null;
      },
    );
  }

  @override
  Future<bool> writeObj<E extends Enum, T extends BaseModel>(
      E key, T obj) async {
    await _ensureInitialized();
    return SecurePreferences.instance
        .setEncryptedValue(key, obj.toString(), _pref)
        .onError(
      (error, stackTrace) {
        return false;
      },
    );
  }

  @override
  Future<Iterable<T>?> readListObj<E extends Enum, T extends BaseModel>(
      E key, T Function(dynamic e) parser) async {
    await _ensureInitialized();
    return SecurePreferences.instance
        .getDecryptedValue(key, _pref)
        .then<Iterable<T>?>((source) {
      if (source != null && source.isNotEmpty) {
        final listObj = jsonDecode(source);
        if (listObj is List) {
          final mapList = listObj.map<T>((dynamic e) => parser(e));
          return mapList;
        }
      }
      return null;
    }).onError(
      (error, stackTrace) {
        return null;
      },
    );
  }

  @override
  Future<bool> writeListObj<E extends Enum, T extends BaseModel>(
      E key, List<T> obj) async {
    await _ensureInitialized();
    return SecurePreferences.instance
        .setEncryptedValue(key, jsonEncode(obj), _pref)
        .onError(
      (error, stackTrace) {
        return false;
      },
    );
  }

  @override
  Future<bool> delete<E extends Enum>(E key) async {
    await _ensureInitialized();
    return SecurePreferences.instance.remove(key, _pref);
  }

  @override
  Future<bool> containsKey<E extends Enum>(E key) async {
    await _ensureInitialized();
    return _pref.containsKey(key.name);
  }

  @override
  Future<bool> clear() async {
    await _ensureInitialized();
    return _pref.clear();
  }
}
