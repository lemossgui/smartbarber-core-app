import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';

abstract class EmailVerificationRepository {
  AsyncResult<EmailVerificationCheckModel, Failure> check({
    required String email,
    required String userType,
  });
  AsyncResult<void, Failure> resend(String email);
  AsyncResult<void, Failure> validate({
    required String email,
    required String verificationCode,
  });
}
