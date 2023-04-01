import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ElevatedPersistentButton extends StatelessWidget {
  final BloC bloc;
  final String text;
  final Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final Widget? onPersisting;
  final Widget? onIdle;
  final Widget? onError;

  const ElevatedPersistentButton({
    required this.bloc,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.onPersisting,
    this.onIdle,
    this.onError,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PersistingState?>(
      stream: bloc.streamOf<PersistingState?>(),
      builder: (streamContext, snapshot) {
        final state = snapshot.data;
        final isIdle = state == null || state == PersistingState.idle;
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              color ?? Theme.of(context).colorScheme.primary,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          onPressed: !isIdle ? null : onPressed,
          child: _buildButtonContent(streamContext, state),
        );
      },
    );
  }

  Widget _buildButtonContent(BuildContext context, PersistingState? state) {
    return Container(
      height: 48.0,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: state == null
          ? _buildText(context)
          : state.isError
              ? onError ?? _buildText(context)
              : state.isIdle
                  ? onIdle ?? _buildText(context)
                  : state.isLoading
                      ? onPersisting ??
                          LoadingAnimationWidget.horizontalRotatingDots(
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 32.0,
                          )
                      : _buildText(context),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
        color: textColor ?? Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
