import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class ComponenteView<T> extends StatefulWidget {
  const ComponenteView({Key? key}) : super(key: key);

  final String? tag = null;

  T get bloc => InjectorImpl().find<T>(tag: tag);

  @override
  State<ComponenteView<T>> createState() => _ComponenteViewState<T>();

  Widget build(BuildContext context);

  void onInit(BuildContext context) {}
  void dispose() {}
}

class _ComponenteViewState<T> extends State<ComponenteView<T>> {
  @override
  void initState() {
    widget.onInit(context);
    super.initState();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: widget.build(context),
    );
  }
}
