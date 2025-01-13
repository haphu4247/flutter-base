import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:modular_storage/src/models/storage_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/base_storage.dart';

class SharedPreferencesStorage implements BaseStorage {
  late SharedPreferences _pref;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      _pref = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  @override
  Future<String?> read<E extends Enum>(E key) async {
    await _ensureInitialized();
    return _getString(key);
  }

  @override
  Future<bool> write<E extends Enum>(E key, String value) async {
    await _ensureInitialized();
    return _saveString(key, value);
  }

  @override
  Future<T?> readObj<E extends Enum, T extends StorageModel>(
      E key, T Function(dynamic e) parser) {
    return _getString(key).then((source) {
      if (source != null) {
        final dynamic json = jsonDecode(source);
        final obj = parser(json);
        return obj;
      }
      return null;
    });
  }

  @override
  Future<bool> writeObj<E extends Enum, T extends StorageModel>(E key, T obj) {
    return _saveString(key, json.toString());
  }

  @override
  Future<Iterable<T>?> readListObj<E extends Enum, T extends StorageModel>(
      E key, T Function(dynamic e) parser) {
    return _getString(key).then<Iterable<T>?>((source) {
      if (source != null && source.isNotEmpty) {
        final listObj = jsonDecode(source);
        if (listObj is List) {
          final mapList = listObj.map<T>((dynamic e) => parser(e));
          return mapList;
        }
      }
      return null;
    });
  }

  @override
  Future<bool> writeListObj<E extends Enum, T extends StorageModel>(
      E key, List<T> obj) {
    return _saveString(key, jsonEncode(obj));
  }

  @override
  Future<bool> delete<E extends Enum>(E key) async {
    await _ensureInitialized();
    return _remove(key);
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

extension _SharedPreferencesStorageExt on SharedPreferencesStorage {
  Future<String?> _getString<E extends Enum>(E key) async {
    final encryptKey = _CryptoHelper.instance.encrypt(key.name);
    var value = _pref.getString(encryptKey);
    if (value != null && value.isNotEmpty) {
      value = _CryptoHelper.instance.decrypt(value);
    }
    return value;
  }

  Future<bool> _remove<E extends Enum>(E key) {
    final encryptKey = _CryptoHelper.instance.encrypt(key.name);
    return _pref.remove(encryptKey);
  }

  //String key, String value
  Future<bool> _saveString<E extends Enum>(E key, String value) async {
    final encryptKey = _CryptoHelper.instance.encrypt(key.name);
    final encryptValue = _CryptoHelper.instance.encrypt(value);
    return _pref.setString(encryptKey, encryptValue);
  }
}

class _CryptoHelper {
  final _key = Key.fromUtf8('ASDFGHJKLASDFGHJ912QWA56CFB3SA3F');
  final _iv = IV.fromLength(16);
  late final Encrypter _encrypter;

  static final instance = _CryptoHelper();

  _CryptoHelper() {
    _encrypter = Encrypter(AES(_key));
  }

  String encrypt(String plainText) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String base64) {
    final decrypted = _encrypter.decrypt64(base64, iv: _iv);
    return decrypted;
  }
}
