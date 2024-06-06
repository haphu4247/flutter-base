import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final List<Duration> retryDelays;

  final bool Function(DioException error)? condition;

  const RetryInterceptor({
    required this.dio,
    this.condition,
    this.retryDelays = const [
      Duration(milliseconds: 1000),
      Duration(milliseconds: 1500),
      Duration(milliseconds: 2000),
    ], // Delay between retries in milliseconds
  });

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Number of retries
    final retries = retryDelays.length;
    if (_shouldRetry(err) && retries > 0) {
      int attempt = 0;
      while (attempt < retries) {
        attempt++;
        try {
          await Future.delayed(retryDelays.elementAt(attempt));
          return handler.resolve(await dio.fetch(err.requestOptions));
        } catch (e) {
          if (attempt >= retries) {
            return super.onError(err, handler);
          }
        }
      }
    }
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    if (condition != null) {
      return condition!.call(err);
    }
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout;
  }
}
