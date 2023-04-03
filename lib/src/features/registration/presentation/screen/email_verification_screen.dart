import 'package:flutter/material.dart';
import 'package:core/core.dart';

class EmailVerificationScreen extends ScreenView<EmailVerificationBloC> {
  EmailVerificationScreen({Key? key}) : super(key: key);

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailVerificationState>(
      stream: bloc.streamOf<EmailVerificationState>(
        key: EmailVerificationStream.state,
      ),
      builder: (context, snapshot) {
        final state = snapshot.data ?? EmailVerificationState.email;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: getBasePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEmailTitle(context, state),
                _buildEmailField(state),
                _buildPasswordTitle(context, state),
                _buildPasswordField(state),
                _buildPasswordConfirmationField(state),
                _buildError(context),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigation(context, state),
        );
      },
    );
  }

  Widget _buildEmailTitle(BuildContext context, EmailVerificationState state) {
    return Visibility(
      visible: state == EmailVerificationState.email,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          'Insira seu endereço de e-mail',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEmailField(EmailVerificationState state) {
    return MyTextFormField(
      stream: bloc.streamOf<String?>(
        key: EmailVerificationStream.email,
      ),
      onChanged: (value) {
        bloc.dispatch<String?>(
          value,
          key: EmailVerificationStream.email,
        );
      },
      hintText: 'E-mail',
      keyboardType: TextInputType.emailAddress,
      isEnable: state == EmailVerificationState.email,
    );
  }

  Widget _buildPasswordTitle(
    BuildContext context,
    EmailVerificationState state,
  ) {
    return Visibility(
      visible: state == EmailVerificationState.password,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 24.0),
        child: Text(
          'Senha de acesso',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPasswordField(EmailVerificationState state) {
    return Visibility(
      visible: state == EmailVerificationState.password,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: MyPasswordField(
          stream: bloc.streamOf<String?>(
            key: EmailVerificationStream.password,
          ),
          onChanged: (value) {
            bloc.dispatch<String?>(
              value,
              key: EmailVerificationStream.password,
            );
          },
          visibilityStream: bloc.streamOf<bool?>(
            key: EmailVerificationStream.passwordIsVisible,
          ),
          onVisibilityChanged: (value) {
            bloc.dispatch<bool?>(
              value,
              key: EmailVerificationStream.passwordIsVisible,
            );
          },
          hintText: 'Senha',
        ),
      ),
    );
  }

  Widget _buildPasswordConfirmationField(EmailVerificationState state) {
    return Visibility(
      visible: state == EmailVerificationState.password,
      child: MyPasswordField(
        stream: bloc.streamOf<String?>(
          key: EmailVerificationStream.passwordConfirmation,
        ),
        onChanged: (value) {
          bloc.dispatch<String?>(
            value,
            key: EmailVerificationStream.passwordConfirmation,
          );
        },
        visibilityStream: bloc.streamOf<bool?>(
          key: EmailVerificationStream.passwordConfirmationIsVisible,
        ),
        onVisibilityChanged: (value) {
          bloc.dispatch<bool?>(
            value,
            key: EmailVerificationStream.passwordConfirmationIsVisible,
          );
        },
        hintText: 'Confirme a senha',
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return MyErrorWidget(
      stream: bloc.streamOf<String?>(key: EmailVerificationStream.error),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    EmailVerificationState state,
  ) {
    return Padding(
      padding: getBasePadding(context),
      child: MyElevatedButton(
        onPressed: () {
          if (state == EmailVerificationState.email) {
            bloc.dispatchEvent(CheckEmailInUse());
          } else {
            bloc.dispatchEvent(ContinueToTheNextRegistrationStep());
          }
          _focusNode.unfocus();
        },
        text: state.mainButtonText,
      ),
    );
  }
}
