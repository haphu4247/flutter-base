import 'base_model.dart';

class BaseResponseListModel<T extends BaseModel> {
  const BaseResponseListModel(this.items);
  final List<T>? items;

  factory BaseResponseListModel.fromJson(dynamic json, T Function(dynamic e) parser) {
    final items = json['items'] as List?;
    if (items != null) {
      final parseItems = items.map<T>((dynamic e) => parser(e)).toList();
      return BaseResponseListModel(parseItems);
    }
    return BaseResponseListModel(null);
  }

  Map<String, dynamic> toJson() {
    return {'items': items?.map((e) => e.toJson).toList()};
  }
}
