import 'package:core/core.dart';

abstract class EmailVerificationStore {
  Future<EmailVerificationCheckModel> check({
    required String email,
    required String userType,
  });
  Future<void> resend(String email);
  Future<void> validate({
    required String email,
    required String verificationCode,
  });
}
