import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

abstract class AuthenticationRepository<T> {
  AsyncResult<String, Failure> authenticate(T model);
}
