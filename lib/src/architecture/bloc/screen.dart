import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

// ignore: must_be_immutable
class Screen<T> extends GetPage<T> {
  Screen({
    required String name,
    required Widget Function() page,
    Transition? transition,
    Duration? transitionDuration,
    Curve? curve,
    Injector? injector,
  }) : super(
          name: name,
          page: page,
          transition: transition,
          transitionDuration: transitionDuration,
          curve: curve ?? Curves.linear,
          binding: injector,
        );
}
