import 'base_model.dart';

class BaseResponseListModel<T extends BaseModel> {
  BaseResponseListModel();
  List<T>? items;

  BaseResponseListModel.fromJson(dynamic json, T Function(dynamic e) creator) {
    final items = json['Items'] as List?;
    if (items != null) {
      this.items = items.map<T>((dynamic e) => creator(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {'Items': items?.map((e) => e.toJson).toList()};
  }
}
