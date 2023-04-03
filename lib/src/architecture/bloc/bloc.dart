import 'dart:developer';

import 'package:multiple_result/multiple_result.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BloC<Event> extends GetxController
    with FancyMixin, HudMixin, NavigatorMixin {
  BuildContext? get context => Get.context;

  @override
  void onInit() {
    listen<Event>(handleEvent);
    dispatchState(LoadingState());
    super.onInit();
  }

  @override
  void onReady() {
    dispatchState(StableState());
    super.onReady();
  }

  @override
  void onClose() {
    fancy.dispose();
    super.onClose();
  }

  Future<void> handleListing({
    required Function action,
    Function? onError,
    Function? onFinish,
  }) async {
    try {
      dispatch<ScreenState>(LoadingState());
      await Future.delayed(const Duration(milliseconds: 700));
      await action();
    } on Exception catch (_) {
      dispatch<ScreenState>(ErrorState());
      onError?.call();
    } finally {
      dispatch<ScreenState>(StableState());
      onFinish?.call();
    }
  }

  Future<void> handlePersist({
    required Function action,
    Function? onError,
    Function? onFinish,
    Object? loadingKey,
  }) async {
    try {
      if (loadingKey != null) dispatch<bool?>(true, key: loadingKey);
      await action();
    } on Exception catch (_) {
      if (loadingKey != null) dispatch<bool?>(false, key: loadingKey);
      onError?.call();
    } finally {
      if (loadingKey != null) dispatch<bool?>(false, key: loadingKey);
      onFinish?.call();
    }
  }

  T getOrThrow<T>(Object key) {
    final value = map[key];
    if (value == null) {
      throw MapException(message: 'Valor nulo para [$key]');
    }
    return value;
  }

  T mapNotNull<T>({
    required Object key,
    required Function() ifNull,
  }) {
    late T value;
    try {
      value = getOrThrow(key);
      return value;
    } on MapException catch (e) {
      ifNull();
      log(e.message);
      return value;
    }
  }

  bool validateStrings(List<Object> keys) {
    bool isValid = true;

    for (var key in keys) {
      String? data = map[key];
      if (data.isNullOrEmpty) {
        dispatch<String?>(data, key: key);
        isValid = false;
      }
    }

    return isValid;
  }

  void showLoadingDialog<S, E>({
    String? message,
    required AsyncResult<S, E> action,
    required Function(Result<S, E> result) onComplete,
  }) async {
    Get.dialog(
      LoadingDialog(message: message),
      barrierDismissible: false,
    );

    final result = await action;

    await Future.delayed(const Duration(milliseconds: 700));

    pop();

    onComplete(result);
  }

  @protected
  void handleEvent(Event event);

  void dispatchEvent(Event event) => dispatch<Event>(event);

  @protected
  void dispatchState(ScreenState state) => dispatch<ScreenState>(state);

  void handleFailure(Failure failure) {
    showError(failure.message);
  }

  @protected
  dynamic get arguments => Get.arguments;
}
