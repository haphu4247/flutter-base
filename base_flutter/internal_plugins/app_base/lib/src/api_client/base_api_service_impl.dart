part of 'base_api_service.dart';

class _BaseApiServiceImpl extends BaseApiService {
  const _BaseApiServiceImpl(super.dio) : super._internal();

  @override
  Future<ApiResponseModel> callApi({
    required ApiParams params,
  }) =>
      _requestData(params);

  @override
  Future<T> callObj<T extends BaseModel>(
      {required ApiParams params, required T Function(dynamic json) parser}) {
    return _requestData(params).then((value) {
      return value.parseObject<T>(parser);
    });
  }

  @override
  Future<List<T>> callList<T extends BaseModel>(
      {required ApiParams params, required T Function(dynamic json) parser}) {
    return _requestData(params).then((value) {
      return value.parseList<T>(parser);
    });
  }

  @override
  Future<ApiResponseModel> uploadFile({
    required List<File> body,
    required ApiParams params,
  }) {
    final list = body.map(
      (e) => MultipartFile.fromFile(
        e.path,
        filename: basename(e.path),
      ),
    );
    final map = <String, dynamic>{
      'file': list,
      // 'userId': userId,
    };
    final data = FormData.fromMap(map);
    final newParams = params.copyWith(
      data: data,
    );
    return _requestData(newParams);
  }
}
