import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionStore local;

  SessionRepositoryImpl({
    required this.local,
  });

  @override
  AsyncResult<void, Failure> save(SessionModel model) async {
    try {
      final result = await local.save(model);
      return Success(result);
    } on StorageException catch (e) {
      final failure = Failure.fromStorage(e);
      return Error(failure);
    }
  }

  @override
  AsyncResult<SessionModel?, Failure> get() async {
    try {
      final result = await local.get();
      return Success(result);
    } on StorageException catch (e) {
      final failure = Failure.fromStorage(e);
      return Error(failure);
    }
  }

  @override
  AsyncResult<void, Failure> clear() async {
    try {
      final result = await local.clear();
      return Success(result);
    } on StorageException catch (e) {
      final failure = Failure.fromStorage(e);
      return Error(failure);
    }
  }

  @override
  Future<bool> get isLogged async {
    final result = await local.get();
    return result != null;
  }
}
