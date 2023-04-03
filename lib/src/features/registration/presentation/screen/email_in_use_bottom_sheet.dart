import 'package:core/core.dart';
import 'package:flutter/material.dart';

class EmailInUseBottomSheet extends ComponenteView<EmailVerificationBloC> {
  const EmailInUseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getBasePadding(context),
      child: StreamBuilder<String?>(
        stream: bloc.streamOf<String?>(
          key: EmailVerificationStream.email,
        ),
        builder: (context, snapshot) {
          final email = snapshot.data ?? '-';
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Este e-mail já está em uso',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Encontramos uma conta cadastrada com o e-mail ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    children: [
                      TextSpan(
                        text: email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildReturnToAccessButton(context),
              _buildUseOtherEmailButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReturnToAccessButton(BuildContext context) {
    return MyElevatedButton(
      onPressed: () => bloc.dispatchEvent(ReturnToAccess()),
      color: Theme.of(context).colorScheme.primaryContainer,
      textColor: Theme.of(context).colorScheme.onPrimaryContainer,
      text: 'Retornar ao login',
    );
  }

  Widget _buildUseOtherEmailButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MyElevatedButton(
        onPressed: () => bloc.pop(),
        color: Theme.of(context).colorScheme.tertiaryContainer,
        textColor: Theme.of(context).colorScheme.onTertiaryContainer,
        text: 'Usar outro e-mail',
      ),
    );
  }
}
