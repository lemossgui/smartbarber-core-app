import 'package:core/core.dart';

enum EmailVerificationStream {
  state,
  error,
  email,
  password,
  passwordIsVisible,
  passwordConfirmation,
  passwordConfirmationIsVisible,
}

enum EmailVerificationState {
  email('Verificar'),
  password('Continuar');

  final String mainButtonText;

  const EmailVerificationState(this.mainButtonText);
}

enum EmailVerificationErrors {
  emailInUse('EMAIL_IN_USE');

  final String key;

  const EmailVerificationErrors(this.key);
}

abstract class EmailVerificationBloC extends BloC<EmailVerificationEvent>
    with RequiredStringStreamValidator {
  static const route = '/email-verification';

  final EmailVerificationRepository repository;

  EmailVerificationBloC({
    required this.repository,
  });

  /// Implementado no client
  void onContinueToTheNextRegistrationStep(AccessModel model);

  @override
  void onInit() {
    _dispatchEmail('guilherme@gmail.com.br');
    _onValuesChange();
    _setupRequiredFields();
    _dispatchInitialState();
    super.onInit();
  }

  void _onValuesChange() {
    listen<String?>(
      (_) => _dispatchError(null),
      key: EmailVerificationStream.email,
    );
    listen<String?>(
      (_) => _dispatchError(null),
      key: EmailVerificationStream.password,
    );
    listen<String?>(
      (_) => _dispatchError(null),
      key: EmailVerificationStream.passwordConfirmation,
    );
  }

  void _setupRequiredFields() {
    addTransformOn<String?, String?>(
      requiredStringStreamValidator(),
      key: EmailVerificationStream.email,
    );
    addTransformOn<String?, String?>(
      requiredStringStreamValidator(),
      key: EmailVerificationStream.password,
    );
    addTransformOn<String?, String?>(
      requiredStringStreamValidator(),
      key: EmailVerificationStream.passwordConfirmation,
    );
  }

  void _dispatchInitialState() {
    _dispatchState(EmailVerificationState.email);
  }

  String _getEmail() {
    return mapNotNull(
      key: EmailVerificationStream.email,
      ifNull: () => _dispatchEmail(null),
    );
  }

  void _dispatchEmail(String? value) {
    dispatch<String?>(
      value,
      key: EmailVerificationStream.email,
    );
  }

  String _getPassword() {
    return mapNotNull(
      key: EmailVerificationStream.password,
      ifNull: () => _dispatchPassword(null),
    );
  }

  void _dispatchPassword(String? value) {
    dispatch<String?>(
      value,
      key: EmailVerificationStream.password,
    );
  }

  String _getPasswordConfirmation() {
    return mapNotNull(
      key: EmailVerificationStream.passwordConfirmation,
      ifNull: () => _dispatchPasswordConfirmation(null),
    );
  }

  void _dispatchPasswordConfirmation(String? value) {
    dispatch<String?>(
      value,
      key: EmailVerificationStream.passwordConfirmation,
    );
  }

  void _dispatchState(EmailVerificationState value) {
    dispatch<EmailVerificationState>(value, key: EmailVerificationStream.state);
  }

  @override
  void handleEvent(EmailVerificationEvent event) {
    if (event is CheckEmailInUse) {
      _checkEmailInUse();
    } else if (event is ContinueToTheNextRegistrationStep) {
      _continueToTheNextRegistrationStep();
    } else if (event is ReturnToAccess) {
      _returnToAccess();
    }
  }

  void _checkEmailInUse() async {
    final isValid = validateStrings([EmailVerificationStream.email]);
    if (!isValid) return;

    final email = _getEmail();

    showLoadingDialog(
      message: 'Verificando e-mail',
      action: repository.check(
        email: email,
        userType: 'BARBERSHOP',
      ),
      onComplete: (result) {
        result.map(_handleCheckEmailSuccess).mapError(handleFailure);
      },
    );
  }

  void _handleCheckEmailSuccess(EmailVerificationCheckModel model) {
    if (model.isChecked) {
      _dispatchState(EmailVerificationState.password);
    } else if (model.inUse) {
      _showEmailInUseBottomSheet();
    } else {
      _showVerificationCodeBottomSheet(model.timeToResend);
    }
  }

  void _showVerificationCodeBottomSheet(int? timeToResend) async {
    final isChecked = await showBottomSheet(
      VerificationCodeBottomSheet(timeToResend: timeToResend),
      route: VerificationCodeBloC.route,
      arguments: _getEmail(),
    ) as bool;

    if (isChecked) {
      _dispatchState(EmailVerificationState.password);
    }
  }

  void _continueToTheNextRegistrationStep() {
    final isValid = _validatePasswords();
    if (!isValid) return;

    final email = _getEmail();
    final password = _getPassword();

    final model = AccessModel(
      email: email,
      password: password,
    );

    onContinueToTheNextRegistrationStep(model);
  }

  bool _validatePasswords() {
    bool isValid = true;

    isValid = validateStrings([
      EmailVerificationStream.password,
      EmailVerificationStream.passwordConfirmation
    ]);

    if (isValid) {
      final password = _getPassword();
      final passwordConfirmation = _getPasswordConfirmation();

      if (password != passwordConfirmation) {
        _dispatchError('As senhas não são iguais');
        isValid = false;
      }
    }

    return isValid;
  }

  @override
  void handleFailure(Failure failure) {
    _dispatchError(failure.message);
  }

  void _dispatchError(String? value) {
    dispatch<String?>(value, key: EmailVerificationStream.error);
  }

  void _showEmailInUseBottomSheet() {
    showBottomSheet(const EmailInUseBottomSheet());
  }

  void _returnToAccess() {
    pop();
  }
}
