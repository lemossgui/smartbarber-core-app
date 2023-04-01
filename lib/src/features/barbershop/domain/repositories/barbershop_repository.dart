import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

abstract class BarbershopRepository {
  AsyncResult<BarbershopModel, Failure> findById(int id);
}
