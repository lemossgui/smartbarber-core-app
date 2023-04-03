import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Stream<bool?>? loadingStream;
  final Color? color;
  final Color? textColor;
  final bool withBorder;
  final bool isEnable;

  const MyTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loadingStream,
    this.color,
    this.textColor,
    this.withBorder = false,
    this.isEnable = true,
  });

  factory MyTextButton.withBorder({
    required String text,
    required Function onPressed,
    final Stream<bool?>? loadingStream,
    Color? textColor,
    bool isEnable = true,
  }) {
    return MyTextButton(
      text: text,
      onPressed: onPressed,
      loadingStream: loadingStream,
      textColor: textColor,
      withBorder: true,
      isEnable: isEnable,
    );
  }

  factory MyTextButton.transparent({
    required String text,
    required Function onPressed,
    final Stream<bool?>? loadingStream,
    bool isEnable = true,
  }) {
    return MyTextButton(
      text: text,
      onPressed: onPressed,
      loadingStream: loadingStream,
      color: Colors.transparent,
      isEnable: isEnable,
    );
  }

  Color? getBackgroundColor(BuildContext context) {
    if (!isEnable) {
      return Theme.of(context).disabledColor;
    } else if (withBorder) {
      return null;
    }
    return color ?? Theme.of(context).colorScheme.tertiary;
  }

  Color getTextColor(BuildContext context) {
    if (!isEnable) {
      return Theme.of(context).colorScheme.outlineVariant;
    } else if (color == Colors.transparent) {
      return Theme.of(context).colorScheme.onBackground;
    }
    return textColor ?? Theme.of(context).colorScheme.onTertiary;
  }

  BorderSide getBorderSide(BuildContext context) {
    if (!withBorder) return BorderSide.none;
    return BorderSide(
      width: 1.0,
      color: textColor ?? Theme.of(context).colorScheme.onTertiary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: loadingStream,
      builder: (context, snapshot) {
        final isLoading = snapshot.data ?? false;
        return TextButton(
          onPressed: isEnable ? () => onPressed() : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(
              getBackgroundColor(context),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.0),
                side: getBorderSide(context),
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              Colors.white.withOpacity(0.3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: isLoading
                ? LoadingAnimationWidget.horizontalRotatingDots(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 32.0,
                  )
                : Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: getTextColor(context)),
                  ),
          ),
        );
      },
    );
  }
}
