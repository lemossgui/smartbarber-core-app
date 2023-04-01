import 'package:core/core.dart';
import 'package:get/get.dart';

extension AbstractModelFunctions<T extends AbstractModel> on List<T> {
  T? firstWhereOrNullById(int? id) {
    return firstWhereOrNull((item) => item.id == id);
  }

  List<int> getIds() {
    return map((e) => e.id).toList();
  }
}
