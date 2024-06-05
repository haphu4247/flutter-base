class APIException implements Exception {
  String message;
  int? code;
  APIException(
      {this.message = 'Unknown exception!', this.code});

  @override
  String toString() => message;
}
