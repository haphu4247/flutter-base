import 'base_model.dart';

class BaseResponseModel<T extends BaseModel> {
  const BaseResponseModel({
    this.code,
    this.message,
    this.data,
  }) : super();

  final String? code;
  final String? message;
  final dynamic data;

  factory BaseResponseModel.fromJson(dynamic json) {
    final code = json['code'] as String?;
    final message = json['message'] as String?;
    final data = json['data'];
    return BaseResponseModel(
      code: code,
      message: message,
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'data': data,
    };
  }

  bool isSuccess() {
    return '200' == code;
  }
}