import 'package:dio_http_cache/src/core/obj.dart';

abstract class ICacheStore {
  const ICacheStore();

  Future<CacheObj?> getCacheObj(String key, {String? subKey});

  Future<bool> setCacheObj(CacheObj obj);

  Future<bool> delete(String key, {String? subKey});

  Future<bool> clearExpired();

  Future<bool> clearAll();
}
