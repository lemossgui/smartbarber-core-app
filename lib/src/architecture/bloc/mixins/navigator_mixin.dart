import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin NavigatorMixin {
  Future<T?>? toNamed<T>(
    String route, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      Get.toNamed(
        route,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );

  Future<T?>? offAllNamed<T>(
    String route, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      Get.offAllNamed(
        route,
        arguments: arguments,
        id: id,
        parameters: parameters,
      );

  Future<T?>? popAndToNamed<T>(
    String route, {
    dynamic arguments,
    int? id,
    dynamic result,
    Map<String, String>? parameters,
  }) =>
      Get.offAndToNamed(
        route,
        arguments: arguments,
        id: id,
        result: result,
        parameters: parameters,
      );

  void pop<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) =>
      Get.back(
        result: result,
        closeOverlays: closeOverlays,
        canPop: canPop,
        id: id,
      );

  Future<T?>? dialog<T>(
    Widget dialog, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    return Get.dialog(
      dialog,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      navigatorKey: navigatorKey,
      arguments: arguments,
      transitionCurve: transitionCurve,
      transitionDuration: transitionDuration,
      name: name,
      routeSettings: routeSettings,
    );
  }

  Future<T?>? popToNamed<T>(
    String route, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      Get.offAllNamed(
        route,
        arguments: arguments,
        id: id,
        parameters: parameters,
      );

  T getArguments<T>() {
    try {
      return Get.arguments as T;
    } on TypeError {
      final message =
          'Não foi possível fazer o mapeamento de arguments para ${T.runtimeType}';
      log(message);
      throw Exception(message);
    }
  }

  Future<T?>? showBottomSheet<T>(
    Widget bottomSheet, {
    String? route,
    dynamic arguments,
    bool isDismissible = false,
  }) {
    Color? backgroundColor;

    final context = Get.key.currentState?.context;
    if (context != null) {
      backgroundColor = Theme.of(context).colorScheme.background;
    }

    return Get.bottomSheet(
      bottomSheet,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      settings: RouteSettings(
        name: route,
        arguments: arguments,
      ),
      isDismissible: isDismissible,
    );
  }
}
