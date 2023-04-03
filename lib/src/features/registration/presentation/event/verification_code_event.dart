abstract class VerificationCodeEvent {}

class CloseVerificationCodeBottomSheet extends VerificationCodeEvent {}

class DispatchTimerToResend extends VerificationCodeEvent {
  final int? timeToResend;

  DispatchTimerToResend({
    this.timeToResend,
  });
}

class ResendVerificationCode extends VerificationCodeEvent {}

class ValidateVerificationCode extends VerificationCodeEvent {}
