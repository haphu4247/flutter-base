import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local_repositories/local_data_key/local_data_key_impl.dart';
import '../models/base_model.dart';

extension LocalDataKeyExt on LocalDataKey {
  Future<bool> remove() {
    return _remove(name);
  }

  Future<bool> setBool(bool value) {
    return setString(value.toString());
  }

  Future<bool?> getBool() async {
    final boolValue = await getString();
    if (boolValue != null) {
      return boolValue == 'true';
    }
    return null;
  }

  Future<bool> setInt(int value) async {
    return setString(value.toString());
  }

  Future<int?> getInt() async {
    final intValue = await getString();
    if (intValue != null) {
      return int.tryParse(intValue);
    }
    return null;
  }

  Future<bool> clear() {
    return SharedPreferences.getInstance().then((value) => value.clear());
  }

  Future<bool> saveObj<T extends BaseModel>(T obj) {
    return save<T>(name, obj);
  }

  Future<T?> getObj<T extends BaseModel>(T Function(dynamic e) parser) {
    return read<T>(name, parser);
  }

  Future<bool> saveListObj<T extends BaseModel>(List<T> obj) {
    return setString(jsonEncode(obj));
  }

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

  Future<bool> setString(String value) {
    return _saveString(name, value);
  }

  static Future<bool> save<T extends BaseModel>(String key, T obj) {
    final savedObj = jsonEncode(obj.toJson());
    return _saveString(key, savedObj);
  }

  static Future<T?> read<T extends BaseModel>(
      String key, T Function(dynamic e) parser) async {
    final source = await _getString(key);
    if (source != null) {
      final dynamic decodeJson = jsonDecode(source);
      final obj = parser(decodeJson);
      return obj;
    }
    return null;
  }

  static Future<bool> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_CryptoHelper.instance.encrypt(key),
        _CryptoHelper.instance.encrypt(value));
  }

  Future<String?> getString() {
    return _getString(name);
  }

  static Future<String?> _getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    // final key = name;
    final encryptKey = _CryptoHelper.instance.encrypt(key);
    var value = prefs.getString(encryptKey);
    if (value != null && value.isNotEmpty) {
      value = _CryptoHelper.instance.decrypt(value);
    }
    return value;
  }

  static Future<bool> _remove(String key) async {
    return SharedPreferences.getInstance().then((prefs) {
      final encryptKey = _CryptoHelper.instance.encrypt(key);
      return prefs.remove(encryptKey);
    });
  }
}

class _CryptoHelper {
  final Key _key = Key.fromUtf8('ASDFGHJKLASDFGHJ912QWA56CFB3SA3F');
  final IV _iv = IV.fromLength(16);
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
