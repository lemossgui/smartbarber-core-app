import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWithDotsWidget extends StatelessWidget {
  const LoadingWithDotsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.horizontalRotatingDots(
      color: Theme.of(context).colorScheme.primary,
      size: 24.0,
    );
  }
}
