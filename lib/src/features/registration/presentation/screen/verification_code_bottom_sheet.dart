import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:core/core.dart';

class VerificationCodeBottomSheet extends ComponenteView<VerificationCodeBloC> {
  final int? timeToResend;

  VerificationCodeBottomSheet({
    super.key,
    required this.timeToResend,
  });

  late final TextEditingController _pinController;
  final _focusNode = FocusNode();
  final _pinLength = 6;

  @override
  void onInit(BuildContext context) {
    bloc.dispatchEvent(DispatchTimerToResend(timeToResend: timeToResend));
    _pinController = TextEditingController();
    super.onInit(context);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getBasePadding(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCloseButton(context),
          _buildTitle(context),
          _buildTextInfo(context),
          _buildResend(context),
          _buildVerificationCodeField(context),
          _buildError(context),
          _buildValidateButton(context),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () {
            bloc.dispatchEvent(CloseVerificationCodeBottomSheet());
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.tertiaryContainer,
            ),
          ),
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Código de verificação',
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Text(
        'Enviamos um código de verificação para você. '
        'Se você não receber o código, pode solicitá-lo '
        'novamente em 1 minuto.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _buildResend(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: bloc.streamOf<bool?>(
        key: VerificationCodeStream.resendButtonIsEnable,
      ),
      builder: (context, snapshot) {
        final isEnable = snapshot.data ?? false;
        return StreamBuilder<String?>(
          stream: bloc.streamOf<String?>(
            key: VerificationCodeStream.timer,
          ),
          builder: (context, snapshot) {
            final timer = snapshot.data ?? '';
            return Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 32.0,
              ),
              child: MyTextButton.transparent(
                loadingStream: bloc.streamOf<bool?>(
                  key: VerificationCodeStream.resendLoading,
                ),
                onPressed: () {
                  _focusNode.unfocus();
                  bloc.dispatchEvent(ResendVerificationCode());
                },
                text: isEnable ? 'Reenviar' : timer,
                isEnable: isEnable,
              ),
            );
          },
        );
      },
    );
  }

  PinTheme _pinTheme(
    BuildContext context,
    Color borderColor,
    bool hasError,
  ) {
    return PinTheme(
      height: 48,
      width: 48,
      textStyle: Theme.of(context).textTheme.titleLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: hasError ? Theme.of(context).colorScheme.error : borderColor,
        ),
        color: Colors.transparent,
      ),
    );
  }

  Widget _buildVerificationCodeField(BuildContext context) {
    return StreamBuilder<String?>(
      stream: bloc.streamOf<String?>(
        key: VerificationCodeStream.verificationCode,
      ),
      builder: (context, snapshot) {
        final hasError = snapshot.hasError;
        return Column(
          children: [
            Pinput(
              length: _pinLength,
              controller: _pinController,
              defaultPinTheme: _pinTheme(
                context,
                Theme.of(context).colorScheme.outline,
                hasError,
              ),
              focusedPinTheme: _pinTheme(
                context,
                Theme.of(context).colorScheme.primary,
                hasError,
              ),
              onChanged: (value) {
                _dispatchVerificationCode(value);
              },
            ),
            Visibility(
              visible: hasError,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${snapshot.error?.toString()}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _dispatchVerificationCode(String value) {
    bloc.dispatch<String?>(
      value,
      key: VerificationCodeStream.verificationCode,
    );
    final isComplete = value.length == _pinLength;
    bloc.dispatch<bool?>(
      isComplete,
      key: VerificationCodeStream.verificationCodeIsComplete,
    );
    if (isComplete) {
      _focusNode.unfocus();
    }
  }

  Widget _buildError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: MyErrorWidget(
        stream: bloc.streamOf<String?>(key: VerificationCodeStream.error),
      ),
    );
  }

  Widget _buildValidateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: MyElevatedButton(
        loadingStream: bloc.streamOf<bool?>(
          key: VerificationCodeStream.validateLoading,
        ),
        onPressed: () {
          _focusNode.unfocus();
          bloc.dispatchEvent(ValidateVerificationCode());
        },
        color: Theme.of(context).colorScheme.primaryContainer,
        textColor: Theme.of(context).colorScheme.onPrimaryContainer,
        text: 'Validar',
      ),
    );
  }
}
