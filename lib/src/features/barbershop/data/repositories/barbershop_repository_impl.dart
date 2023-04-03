import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final BarbershopStore remote;

  BarbershopRepositoryImpl({
    required this.remote,
  });

  @override
  AsyncResult<BarbershopModel, Failure> findById(int id) async {
    try {
      final result = await remote.findById(id);
      return Success(result);
    } on RemoteException catch (e) {
      final failure = Failure.fromRemote(e);
      return Error(failure);
    }
  }
}
