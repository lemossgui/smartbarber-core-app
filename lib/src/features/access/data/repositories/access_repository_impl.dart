import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

class AccessRepositoryImpl extends AccessRepository {
  final AccessStore remote;

  AccessRepositoryImpl({
    required this.remote,
  });

  @override
  AsyncResult<String, Failure> authenticate(AccessModel model) async {
    try {
      final result = await remote.authenticate(model);
      return Success(result);
    } on RemoteException catch (e) {
      final failure = Failure.fromRemote(e);
      return Error(failure);
    }
  }
}
