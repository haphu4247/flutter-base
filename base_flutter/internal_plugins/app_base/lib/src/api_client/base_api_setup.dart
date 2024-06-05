enum HTTPMethod { get, post, delete, put, patch }

abstract class BaseApiSetup {
  String getPath(dynamic appendPath);

  HTTPMethod get method;

  String get contentType => 'application/x-www-form-urlencoded';

  String get apiName;
}
