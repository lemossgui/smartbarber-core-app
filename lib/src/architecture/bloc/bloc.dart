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
