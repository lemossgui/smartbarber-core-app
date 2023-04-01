import 'package:core/core.dart';

abstract class BarbershopStore {
  Future<BarbershopModel> findById(int id);
}
