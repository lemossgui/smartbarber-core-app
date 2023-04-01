import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StreamTextField extends StatefulWidget {
  final Stream<bool>? streamEnable;
  final bool requiredField;
  final Stream<String?> stream;
  final Function(String?) onChanged;
  final Function()? onClearPressed;
  final bool obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Function()? onTap;
  final bool readOnly;
  final bool enable;
  final bool isExpanded;
  final List<TextInputFormatter>? inputFormatters;

  const StreamTextField({
    Key? key,
    this.streamEnable,
    this.requiredField = false,
    required this.stream,
    this.onClearPressed,
    required this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.enable = true,
    this.isExpanded = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<StreamTextField> createState() => _StreamTextFieldState();
}

class _StreamTextFieldState extends State<StreamTextField> {
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

  Widget _buildTextFormField() {
    return StreamBuilder<String?>(
      stream: widget.stream,
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
        return widget.streamEnable != null
            ? StreamBuilder<bool>(
                stream: widget.streamEnable,
                builder: (_, snapshotEnable) {
                  final enable = snapshotEnable.data ?? true;
                  return _buildTextField(enable, snapshotText.error);
                },
              )
            : _buildTextField(true, snapshotText.error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isExpanded
        ? Expanded(
            child: _buildTextFormField(),
          )
        : _buildTextFormField();
  }

  Widget _buildTextField(bool enable, Object? error) {
    return TextFormField(
      readOnly: widget.readOnly,
      enabled: enable,
      controller: controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      onTap: widget.onTap,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
      decoration: InputDecoration(
        labelText: widget.hintText,
        errorText: error?.toString(),
      ).copyWithDefault(context),
      inputFormatters: widget.inputFormatters,
    );
  }
}
