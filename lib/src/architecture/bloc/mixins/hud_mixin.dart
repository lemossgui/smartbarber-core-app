import 'package:get/get.dart';
import 'package:flutter/material.dart';

mixin HudMixin {
  void showSnackBar(
    String message, {
    String? title,
    required Color backgroundColor,
    SnackPosition? position,
    Widget? icon,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        backgroundColor: backgroundColor,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(8.0),
        duration: const Duration(seconds: 3),
        snackPosition: position ?? SnackPosition.TOP,
        icon: icon,
        boxShadows: [
          BoxShadow(
            color: const Color.fromARGB(255, 71, 46, 46).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  void showSuccess(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green[300] ?? Colors.transparent,
      icon: const Icon(Icons.check_circle_rounded),
    );
  }

  void showInfo(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.blue[300] ?? Colors.transparent,
      icon: const Icon(Icons.info_rounded),
    );
  }

  void showWarning(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.amber[300] ?? Colors.transparent,
      icon: const Icon(Icons.warning_rounded),
    );
  }

  void showError(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.red[300] ?? Colors.transparent,
      icon: const Icon(Icons.cancel_rounded),
    );
  }
}
