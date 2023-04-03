import 'package:core/core.dart';

class EmailVerificationCheckMapper
    extends AbstractMapper<EmailVerificationCheckModel> {
  @override
  EmailVerificationCheckModel fromMap(Map<String, dynamic> map) {
    return EmailVerificationCheckModel(
      inUse: map['inUse'],
      isChecked: map['isChecked'],
      timeToResend: map['timeToResend'],
    );
  }

  @override
  Map<String, dynamic> toMap(EmailVerificationCheckModel model) {
    throw UnimplementedError();
  }
}
