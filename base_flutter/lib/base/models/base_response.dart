import '../../shared/utils/utils_string.dart';
import 'base_model.dart';

class BaseResponse<T> extends BaseModel {
  const BaseResponse(
      {this.isOK,
      this.resultCode,
      this.resultMessage,
      dynamic data,
      this.dataKey = ''})
      : super(data: data);

  final String? isOK;
  final String? resultCode;
  final String? resultMessage;
  final String dataKey;

  factory BaseResponse.fromJson(dynamic json, {String dataKey = ''}) {
    final isOK = json['IsOK'] as String? ?? UtilsString.parse(json['status']);

    final resultCode =
        json['ResultCode'] as String? ?? UtilsString.parse(json['code']);

    final resultMessage =
        json['ResultMessage'] as String? ?? UtilsString.parse(json['message']);
    dynamic data;
    if (dataKey.isEmpty) {
      data = json;
    } else {
      data = json[dataKey];
    }
    return BaseResponse<T>(
      isOK: isOK,
      resultCode: resultCode,
      resultMessage: resultMessage,
      data: data,
      dataKey: dataKey,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'IsOK': isOK,
      'ResultCode': resultCode,
      'ResultMessage': resultMessage,
      'data': data,
    };
  }

  bool isSuccess() {
    return 'true' == isOK || 'success'.containIgnoreCase(resultMessage);
  }
}
