import 'package:dio_http_cache/src/store/cache_encryption.dart';
import 'package:dio_http_cache/src/store/store_impl.dart';

typedef Encrypt<T> = Future<T> Function(T str);
typedef Decrypt<T> = Future<T> Function(T str);

class CacheConfig<T> {
  final Duration defaultMaxAge;
  final Duration? defaultMaxStale;
  final String? databasePath;
  final String databaseName;
  final String? baseUrl;
  final String defaultRequestMethod;

  final bool skipMemoryCache;
  final bool skipDiskCache;

  final int maxMemoryCacheCount;

  final ICacheStore? diskStore;
  final CacheEncryption<T>? encryption;

  CacheConfig({
    this.defaultMaxAge = const Duration(days: 7),
    this.defaultMaxStale,
    this.defaultRequestMethod = 'POST',
    this.databasePath,
    this.databaseName = 'DioCache',
    this.baseUrl,
    this.skipDiskCache = false,
    this.skipMemoryCache = false,
    this.maxMemoryCacheCount = 100,
    this.diskStore,
    this.encryption,
  });
}
