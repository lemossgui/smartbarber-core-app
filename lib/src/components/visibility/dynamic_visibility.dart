import 'package:flutter/material.dart';

class DynamicVisibility extends StatelessWidget {
  final bool isVisible;
  final Widget child;

  const DynamicVisibility({
    Key? key,
    required this.isVisible,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: child,
      replacement: const SizedBox.shrink(),
    );
  }
}
