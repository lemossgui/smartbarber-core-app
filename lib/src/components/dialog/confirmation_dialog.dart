import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;

  const ConfirmationDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.all(32.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64.0,
            width: 64.0,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(48.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.help_outline,
              size: 32.0,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer),
            ),
          ),
        ],
      ),
      actions: [
        MyTextButton(
          onPressed: () => Get.back<bool>(result: false),
          label: 'Fechar',
          textColor: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
        MyTextButton(
          onPressed: () => Get.back<bool>(result: true),
          label: 'Confirmar',
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          textColor: Theme.of(context).colorScheme.onTertiary,
        )
      ],
    );
  }
}
