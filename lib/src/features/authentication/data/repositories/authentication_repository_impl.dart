import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

class AuthenticationRepositoryImpl<T> extends AuthenticationRepository<T> {
  final AuthenticationStore<T> remote;

  AuthenticationRepositoryImpl({
    required this.remote,
  });

  @override
  AsyncResult<String, Failure> authenticate(T model) async {
    try {
      final result = await remote.authenticate(model);
      return Success(result);
    } on RemoteException catch (e) {
      final failure = Failure(e.message);
      return Error(failure);
    }
  }
}
