part of 'base_api_service.dart';

class _BaseApiServiceImpl extends BaseApiService {
  const _BaseApiServiceImpl({required this.dio}) : super._internal();

  final Dio dio;

  @override
  Future<MyResponse<T>> callApi<T extends BaseModel>(
    BaseApiSetup apiSetup, {
    String? appendPath,
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headerParams = const {'accept': 'application/json'},
  }) {
    return _requestData<T>(
      BaseParams(
          apiSetup: apiSetup,
          appendPath: appendPath,
          bodyParams: body,
          headerParams: headerParams,
          queryParams: queryParams),
    );
  }

  @override
  Future<T> callObj<T extends BaseModel>(BaseApiSetup apiSetup,
      {String? appendPath,
      body,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headerParams,
      required T Function(dynamic json) generator}) {
    return _requestData<T>(
      BaseParams(
          apiSetup: apiSetup,
          appendPath: appendPath,
          bodyParams: body,
          headerParams: headerParams,
          queryParams: queryParams),
    ).then((value) {
      return value.parseObject(generator);
    });
  }

  @override
  Future<List<T>> callList<T extends BaseModel>(BaseApiSetup apiSetup,
      {String? appendPath,
      body,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headerParams,
      required T Function(dynamic json) generator}) {
    return _requestData<T>(
      BaseParams(
          apiSetup: apiSetup,
          appendPath: appendPath,
          bodyParams: body,
          headerParams: headerParams,
          queryParams: queryParams),
    ).then((value) {
      return value.parseList(generator);
    });
  }

  @override
  Future<MyResponse<T>> uploadFile<T extends BaseModel>(
    BaseApiSetup apiSetup,
    String userId,
    String accessToken,
    List<File> body, {
    String? appendPath,
  }) {
    final list = body.map(
      (e) => MultipartFile.fromFile(
        e.path,
        filename: p.basename(e.path),
      ),
    );
    final map = <String, dynamic>{
      'file': list,
      'userId': userId,
    };
    final form = FormData.fromMap(map);
    final header = getAuthHeader(accessToken);
    return _requestData<T>(BaseParams(
        appendPath: appendPath,
        apiSetup: apiSetup,
        bodyParams: form,
        headerParams: header));
  }
}

extension _BaseApiServiceImplExt on _BaseApiServiceImpl {
  Future<MyResponse<T>> _requestData<T extends BaseModel>(BaseParams params) {
    return dio
        .request(
      params.url,
      queryParameters: params.query,
      options: params.options,
      data: params.body,
    )
        .then((value) {
      return MyResponse<T>(
        requestOptions: value.requestOptions,
        data: value.data,
        statusCode: value.statusCode,
      );
    });
  }
}
