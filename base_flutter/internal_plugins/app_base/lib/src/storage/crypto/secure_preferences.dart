import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurePreferences {
  final _key = Key.fromUtf8('ASDFGHJKLASDFGHJ912QWA56CFB3SA3F');
  late final _hashKey = _key.hashCode;
  final _iv = IV.fromLength(16);
  late final Encrypter _encrypter;

  static final instance = SecurePreferences();

  SecurePreferences() {
    _encrypter = Encrypter(AES(_key));
  }

  String hashPreKey<E extends Enum>(E key) {
    return (_hashKey.hashCode + key.hashCode).toString();
  }

  String _encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String _decrypt(String base64) {
    final decrypted = _encrypter.decrypt64(base64, iv: _iv);
    return decrypted;
  }

  Future<String?> getDecryptedValue<E extends Enum>(
      E key, SharedPreferences pref) async {
    final hashKey = hashPreKey(key);
    var value = pref.getString(hashKey);
    if (value != null && value.isNotEmpty) {
      value = _decrypt(value);
    }
    return value;
  }

  Future<bool> remove<E extends Enum>(E key, SharedPreferences pref) {
    return pref.remove(key.name);
  }

  //String key, String value
  Future<bool> setEncryptedValue<E extends Enum>(
      E key, String value, SharedPreferences pref) async {
    final hashKey = hashPreKey(key);
    final encryptValue = _encrypt(value);
    return pref.setString(hashKey, encryptValue);
  }
}
