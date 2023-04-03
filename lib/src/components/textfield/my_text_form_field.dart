import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/core.dart';
import 'dart:async';

class MyTextFormField extends StatefulWidget {
  final int? maxLength;
  final String? hintText;
  final Stream<String?> stream;
  final Function(String?) onChanged;
  final TextInputType? keyboardType;
  final Stream<bool?>? enableStream;
  final bool? isEnable;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextFormField({
    Key? key,
    this.maxLength,
    this.hintText,
    required this.stream,
    required this.onChanged,
    this.keyboardType,
    this.enableStream,
    this.isEnable,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _isInitialized = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.stream.listen((data) {
      if (!_isInitialized && data != null) {
        _controller.text = data;
      }
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: widget.enableStream,
      builder: (_, enableSnapshot) {
        final isEnableStream = enableSnapshot.data;
        return StreamBuilder<String?>(
          stream: widget.stream,
          builder: (context, snapshot) {
            return TextFormField(
              key: widget.key,
              maxLength: widget.maxLength,
              enabled: isEnableStream ?? widget.isEnable,
              controller: _controller,
              keyboardType: widget.keyboardType,
              onChanged: (value) {
                if (widget.keyboardType != TextInputType.text) {
                  widget.onChanged(value.trim());
                }
              },
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              decoration: InputDecoration(
                labelText: widget.hintText,
                errorText: snapshot.error?.toString(),
              ).copyWithDefault(context),
              inputFormatters: widget.inputFormatters,
            );
          },
        );
      },
    );
  }
}
