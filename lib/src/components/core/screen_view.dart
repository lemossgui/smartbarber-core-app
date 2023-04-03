import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class ScreenView<T> extends StatefulWidget {
  const ScreenView({Key? key}) : super(key: key);

  final String? tag = null;

  T get bloc => InjectorImpl().find<T>(tag: tag);

  @override
  State<ScreenView<T>> createState() => _ScreenViewState<T>();

  Widget build(BuildContext context);

  void onInit(BuildContext context) {}
}

class _ScreenViewState<T> extends State<ScreenView<T>> {
  @override
  void initState() {
    widget.onInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: widget.build(context),
    );
  }
}
