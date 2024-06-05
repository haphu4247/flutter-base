import 'dart:convert';
import 'dart:core';

import 'package:app_base/app_base.dart';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseLocalDataImpl<E extends Enum> extends BaseLocalData<E> {
  const BaseLocalDataImpl(super.type, this._name);

  final String _name;

  @override
  Future<bool> remove() {
    return _remove(_name);
  }

  @override
  Future<bool> setBool(bool value) {
    return setString(value.toString());
  }

  @override
  Future<bool?> getBool() async {
    final boolValue = await getString();
    if (boolValue != null) {
      return boolValue == 'true';
    }
    return null;
  }

  @override
  Future<bool> setInt(int value) {
    return setString(value.toString());
  }

  @override
  Future<int?> getInt() async {
    final intValue = await getString();
    if (intValue != null) {
      return int.tryParse(intValue);
    }
    return null;
  }

  @override
  Future<String?> getString() {
    return _getString(_name);
  }

  @override
  Future<bool> saveObj<T extends BaseModel>(T obj) {
    return _saveString(_name, obj.toString());
  }

  @override
  Future<T?> getObj<T extends BaseModel>(T Function(dynamic e) parser) async {
    final source = await _getString(_name);
    if (source != null) {
      final dynamic decodeJson = jsonDecode(source);
      final obj = parser(decodeJson);
      return obj;
    }
    return null;
  }

  @override
  Future<bool> saveListObj<T extends BaseModel>(List<T> obj) {
    return setString(jsonEncode(obj));
  }

  @override
  Future<List<T>?> getListObj<T extends BaseModel>(
      T Function(dynamic e) parser) async {
    final source = await getString();
    if (source != null) {
      final listObj = jsonDecode(source);
      if (listObj is List) {
        final mapList = listObj.map((dynamic e) => parser(e)).toList();
        return mapList;
      }
    }
    return null;
  }

  @override
  Future<bool> setString(String value) {
    return _saveString(_name, value);
  }

  @override
  Future<bool> clearAll() {
    return SharedPreferences.getInstance().then((value) => value.clear());
  }
}

extension _BaseLocalDataImplExt on BaseLocalDataImpl {
  Future<String?> _getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encryptKey = _CryptoHelper.instance.encrypt(key);
    var value = prefs.getString(encryptKey);
    if (value != null && value.isNotEmpty) {
      value = _CryptoHelper.instance.decrypt(value);
    }
    return value;
  }

  Future<bool> _remove(String key) async {
    return SharedPreferences.getInstance().then((prefs) {
      final encryptKey = _CryptoHelper.instance.encrypt(key);
      return prefs.remove(encryptKey);
    });
  }

  //String key, String value
  Future<bool> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_CryptoHelper.instance.encrypt(key),
        _CryptoHelper.instance.encrypt(value));
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
