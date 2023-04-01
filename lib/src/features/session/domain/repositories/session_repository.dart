import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

abstract class SessionRepository {
  AsyncResult<void, Failure> save(SessionModel model);
  AsyncResult<SessionModel?, Failure> get();
  AsyncResult<void, Failure> clear();
  Future<bool> get isLogged;
}
