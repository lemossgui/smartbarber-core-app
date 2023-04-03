import 'package:core/core.dart';
import 'dart:async';

enum VerificationCodeStream {
  email,
  verificationCode,
  verificationCodeIsComplete,
  validateLoading,
  timer,
  resendButtonIsEnable,
  resendLoading,
  error,
}

enum VerificationCodeError {
  waitToResendVerificationCode('WAIT_TO_RESEND_VERIFICATION_CODE'),
  verificationCodeInvalid('VERIFICATION_CODE_INVALID'),
  verificationCodoNotFound('VERIFICATION_CODE_NOT_FOUND');

  final String key;

  const VerificationCodeError(this.key);
}

class VerificationCodeBloC extends BloC<VerificationCodeEvent>
    with RequiredStringStreamValidator {
  static const route = '/verification-code';

  final EmailVerificationRepository repository;

  VerificationCodeBloC({
    required this.repository,
  });

  @override
  void onInit() {
    _handleArguments();
    _setupRequiredFields();
    _onVerificationCodeChange();
    super.onInit();
  }

  void _onVerificationCodeChange() {
    listen<String?>((_) {
      _dispatchError(null);
    }, key: VerificationCodeStream.verificationCode);
  }

  Timer? _timer;

  String? get _verificationCode => map[VerificationCodeStream.verificationCode];
  bool get _verificationCodeIsComplete =>
      map[VerificationCodeStream.verificationCodeIsComplete] ?? false;

  void _dispatchEmail(String value) {
    dispatch<String>(value, key: VerificationCodeStream.email);
  }

  void _dispatchVerificationCode(String? value) {
    dispatch<String?>(value, key: VerificationCodeStream.verificationCode);
  }

  void _handleArguments() {
    final email = getArguments() as String;
    _dispatchEmail(email);
  }

  void _setupRequiredFields() {
    addTransformOn<String?, String?>(
      requiredStringStreamValidator(
        message: 'É necessário informar os 6 dígitos do código.',
      ),
      key: VerificationCodeStream.verificationCode,
    );
  }

  @override
  void handleEvent(VerificationCodeEvent event) {
    if (event is CloseVerificationCodeBottomSheet) {
      _closeVerificationCodeBottomSheet();
    } else if (event is DispatchTimerToResend) {
      _dispatchTimer(event.timeToResend);
    } else if (event is ResendVerificationCode) {
      _resendVerificationCode();
    } else if (event is ValidateVerificationCode) {
      _validateVerificationCode();
    }
  }

  void _closeVerificationCodeBottomSheet() {
    _timer?.cancel();
    pop(result: false);
  }

  void _dispatchTimer(int? timeToResend) {
    if (timeToResend == null) {
      dispatch<bool?>(true, key: VerificationCodeStream.resendButtonIsEnable);
    } else {
      int seconds = timeToResend;

      dispatch<bool?>(false, key: VerificationCodeStream.resendButtonIsEnable);

      Timer.periodic(const Duration(seconds: 1), (timer) {
        _timer = timer;
        if (seconds > 0) {
          seconds--;

          final minutes = seconds ~/ 60;
          final minutesStr = minutes.toString().padLeft(2, '0');
          final secondsStr = seconds.toString().padLeft(2, '0');

          dispatch<String?>(
            '$minutesStr:$secondsStr',
            key: VerificationCodeStream.timer,
          );
        } else {
          timer.cancel();
          dispatch<bool?>(true,
              key: VerificationCodeStream.resendButtonIsEnable);
        }
      });
    }
  }

  void _resendVerificationCode() {
    _dispatchError(null);
    handlePersist(
      action: () async {
        final email = _getEmail();
        final result = await repository.resend(email);
        result.map(_onResendSuccess).mapError(handleFailure);
      },
      loadingKey: VerificationCodeStream.resendLoading,
    );
  }

  void _onResendSuccess(_) {
    _dispatchTimer(60);
  }

  bool _verificationCodeIsValid() {
    final isValid = _verificationCode != null && _verificationCodeIsComplete;
    if (!isValid) _dispatchVerificationCode(null);
    return isValid;
  }

  String _getVerificationCode() {
    return mapNotNull(
      key: VerificationCodeStream.verificationCode,
      ifNull: () => _dispatchVerificationCode(null),
    );
  }

  String _getEmail() {
    return mapNotNull(
      key: VerificationCodeStream.email,
      ifNull: () => _dispatchVerificationCode(null),
    );
  }

  void _validateVerificationCode() async {
    _dispatchError(null);

    if (!_verificationCodeIsValid()) return;

    final email = _getEmail();
    final verificationCode = _getVerificationCode();

    handlePersist(
      action: () async {
        final result = await repository.validate(
          email: email,
          verificationCode: verificationCode,
        );

        result.map(_onValidateSuccess).mapError(handleFailure);
      },
      loadingKey: VerificationCodeStream.validateLoading,
    );
  }

  void _onValidateSuccess(_) {
    _timer?.cancel();
    pop(result: true);
  }

  @override
  void handleFailure(Failure failure) {
    _dispatchError(failure.message);
  }

  void _dispatchError(String? message) {
    dispatch<String?>(message, key: VerificationCodeStream.error);
  }
}
