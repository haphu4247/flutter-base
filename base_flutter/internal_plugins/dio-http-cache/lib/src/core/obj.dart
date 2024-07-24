import 'package:dio_http_cache/dio_http_cache.dart';

class CacheObj<T> {
  String key;
  String? subKey;
  int? maxAgeDate;
  int? maxStaleDate;
  List<int>? content;
  int? statusCode;
  List<int>? headers;

  final CacheEncryption<T> _encryption;

  factory CacheObj(String key, List<int> content,
      {String? subKey = '',
      Duration? maxAge,
      Duration? maxStale,
      int? statusCode = 200,
      List<int>? headers,
      CacheEncryption<T>? encryption}) {
    return CacheObj._(key, subKey, content, statusCode, headers,
        encryption: encryption)
      ..maxAge = maxAge
      ..maxStale = maxStale;
  }

  CacheObj._(this.key, this.subKey, this.content, this.statusCode, this.headers,
      {CacheEncryption<T>? encryption})
      : _encryption = encryption ?? CacheEncryption<T>();

  set maxAge(Duration? duration) {
    if (null != duration) {
      maxAgeDate = _convertDuration(duration);
    }
  }

  set maxStale(Duration? duration) {
    if (null != duration) {
      maxStaleDate = _convertDuration(duration);
    }
  }

  Future<List<int>?> encryptContent() async {
    if (content != null && content is T) {
      final result = await _encryption.encryptCacheStr(content as T);
      return result as List<int>;
    }
    return null;
  }

  Future<List<int>?> decryptContent() async {
    if (content != null && content is T) {
      final result = await _encryption.decryptCacheStr(content as T);
      return result as List<int>;
    }
    return null;
  }

  Future<List<int>?> encryptHeaders() async {
    if (content != null && content is T) {
      final result = await _encryption.encryptCacheStr(content as T);
      return result as List<int>;
    }
    return null;
  }

  Future<List<int>?> decryptHeaders() async {
    if (content != null && content is T) {
      final result = await _encryption.decryptCacheStr(content as T);
      return result as List<int>;
    }
    return null;
  }

  int _convertDuration(Duration duration) =>
      DateTime.now().add(duration).millisecondsSinceEpoch;

  factory CacheObj.fromJson(Map<String, dynamic> json) {
    return CacheObj(
      json['key'] as String,
      (json['content'] as List<dynamic>).map((e) => e as int).toList(),
      subKey: json['subKey'] as String?,
      statusCode: json['statusCode'] as int?,
      headers:
          (json['headers'] as List<dynamic>?)?.map((e) => e as int).toList(),
    )
      ..maxAgeDate = json['max_age_date'] as int?
      ..maxStaleDate = json['max_stale_date'] as int?;
  }

  Map<String, dynamic> toJson() {
    final instance = this;
    return <String, dynamic>{
      'key': instance.key,
      'subKey': instance.subKey,
      'max_age_date': instance.maxAgeDate,
      'max_stale_date': instance.maxStaleDate,
      'content': instance.content,
      'statusCode': instance.statusCode,
      'headers': instance.headers,
    };
  }
}
