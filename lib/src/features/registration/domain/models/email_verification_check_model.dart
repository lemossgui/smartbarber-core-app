class EmailVerificationCheckModel {
  final bool inUse;
  final bool isChecked;

  // in seconds
  final int? timeToResend;

  EmailVerificationCheckModel({
    required this.inUse,
    required this.isChecked,
    required this.timeToResend,
  });
}
