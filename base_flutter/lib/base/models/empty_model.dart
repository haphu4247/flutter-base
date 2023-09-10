import 'base_model.dart';

class EmptyModel extends BaseModel {
  const EmptyModel() : super();

  factory EmptyModel.fromJson() {
    return const EmptyModel();
  }

  @override
  Map<dynamic, dynamic> toJson() {
    return <dynamic, dynamic>{};
  }
}
