import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Stream<bool?>? loadingStream;
  final Color? color;
  final Color? textColor;
  final bool withBorder;

  const MyElevatedButton({
    required this.text,
    required this.onPressed,
    this.loadingStream,
    this.color,
    this.textColor,
    this.withBorder = false,
    Key? key,
  }) : super(key: key);

  factory MyElevatedButton.withBorder({
    required String text,
    required Function()? onPressed,
    Stream<bool?>? loadingStream,
    Color? textColor,
    Widget? onPersisting,
    Widget? onIdle,
    Widget? onError,
  }) {
    return MyElevatedButton(
      loadingStream: loadingStream,
      text: text,
      onPressed: onPressed,
      textColor: textColor,
      withBorder: true,
    );
  }

  Color? getBackgroundColor(BuildContext context) {
    if (withBorder) return null;
    return color ?? Theme.of(context).colorScheme.primaryContainer;
  }

  Color getTextColor(BuildContext context) {
    return textColor ?? Theme.of(context).colorScheme.onPrimaryContainer;
  }

  BorderSide getBorderSide(BuildContext context) {
    if (!withBorder) return BorderSide.none;
    return BorderSide(
      width: 1.0,
      color: textColor ?? Theme.of(context).colorScheme.onPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: loadingStream,
      builder: (streamContext, snapshot) {
        final isLoading = snapshot.data ?? false;
        return ElevatedButton(
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
          ),
          onPressed: isLoading ? null : onPressed,
          child: Container(
            height: 48.0,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48.0),
            ),
            child: isLoading
                ? LoadingAnimationWidget.horizontalRotatingDots(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 32.0,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                      color: getTextColor(context),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
