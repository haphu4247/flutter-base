import 'base_model.dart';

class ResponseListModel<T extends BaseModel> {
  ResponseListModel();
  List<T>? items;

  ResponseListModel.fromJson(dynamic json, T Function(dynamic e) creator) {
    final items = json['Items'] as List?;
    if (items != null) {
      this.items = items.map<T>((dynamic e) => creator(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Items'] = items?.map((e) => e.toJson()).toList();
    return data;
  }
}
