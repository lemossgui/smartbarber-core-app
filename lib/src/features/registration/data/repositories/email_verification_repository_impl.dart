import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

class EmailVerificationRepositoryImpl implements EmailVerificationRepository {
  final EmailVerificationStore remote;

  EmailVerificationRepositoryImpl({
    required this.remote,
  });

  @override
  AsyncResult<EmailVerificationCheckModel, Failure> check({
    required String email,
    required String userType,
  }) async {
    try {
      final result = await remote.check(
        email: email,
        userType: userType,
      );
      return Success(result);
    } on RemoteException catch (e) {
      final failure = Failure.fromRemote(e);
      return Error(failure);
    }
  }

  @override
  AsyncResult<void, Failure> resend(String email) async {
    try {
      final result = await remote.resend(email);
      return Success(result);
    } on RemoteException catch (e) {
      final failure = Failure.fromRemote(e);
      return Error(failure);
    }
  }

  @override
  AsyncResult<void, Failure> validate({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final result = await remote.validate(
        email: email,
        verificationCode: verificationCode,
      );
      return Success(result);
    } on RemoteException catch (e) {
      final failure = Failure.fromRemote(e);
      return Error(failure);
    }
  }
}
