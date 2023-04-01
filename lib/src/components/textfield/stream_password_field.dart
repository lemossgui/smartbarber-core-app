import 'package:core/core.dart';
import 'package:flutter/material.dart';

class StreamPasswordField extends StatefulWidget {
  final Stream<String?> textStream;
  final Function(String?) onTextChanged;
  final Stream<bool?> visibilityStream;
  final Function(bool?) onVisibilityChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLength;

  const StreamPasswordField({
    super.key,
    required this.textStream,
    required this.onTextChanged,
    required this.visibilityStream,
    required this.onVisibilityChanged,
    required this.hintText,
    this.keyboardType,
    this.maxLength,
  });

  @override
  State<StreamPasswordField> createState() => _StreamPasswordFieldState();
}

class _StreamPasswordFieldState extends State<StreamPasswordField> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: widget.textStream,
      builder: (context, snapshotText) {
        if (snapshotText.hasData) {
          controller.text = snapshotText.data!;
          controller.selection = TextSelection.collapsed(
            offset: controller.text.length,
          );
        } else {
          controller.text = '';
          controller.value = TextEditingValue.empty;
        }
        return StreamBuilder<bool?>(
          stream: widget.visibilityStream,
          builder: (_, snapshot) {
            final isVisible = snapshot.data ?? false;
            return TextFormField(
              controller: controller,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              maxLength: widget.maxLength,
              onChanged: widget.onTextChanged,
              obscureText: !isVisible,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              decoration: InputDecoration(
                labelText: widget.hintText,
                errorText: snapshotText.error?.toString(),
                suffixIcon: IconButton(
                  onPressed: (() => widget.onVisibilityChanged(!isVisible)),
                  icon: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ).copyWithDefault(context),
            );
          },
        );
      },
    );
  }
}
