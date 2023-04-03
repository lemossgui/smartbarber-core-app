import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

abstract class AccessRepository {
  AsyncResult<String, Failure> authenticate(AccessModel model);
}
