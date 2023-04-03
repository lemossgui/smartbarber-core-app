import 'package:flutter/material.dart';
import 'package:core/core.dart';

class MyPasswordField extends StatefulWidget {
  final String hintText;
  final Stream<String?> stream;
  final Function(String?) onChanged;
  final Stream<bool?> visibilityStream;
  final Function(bool?) onVisibilityChanged;

  const MyPasswordField({
    Key? key,
    required this.hintText,
    required this.stream,
    required this.onChanged,
    required this.visibilityStream,
    required this.onVisibilityChanged,
  }) : super(key: key);

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: widget.stream,
      builder: (context, snapshot) {
        return StreamBuilder<bool?>(
          stream: widget.visibilityStream,
          builder: (_, snapshotVisibility) {
            final isVisible = snapshotVisibility.data ?? false;
            return TextFormField(
              controller: _controller,
              onChanged: (value) {
                widget.onChanged(value.trim());
              },
              obscureText: !isVisible,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              decoration: InputDecoration(
                labelText: widget.hintText,
                errorText: snapshot.error?.toString(),
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
