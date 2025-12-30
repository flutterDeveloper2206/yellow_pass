

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';

class CommonSnackbar {
  static void show({
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final context = Get.context;
    if (context == null) return;

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showError({required String message, String title = "Error"}) {
    show(
      title: title,
      message: message,
      contentType: ContentType.failure,
    );
  }

  static void showSuccess({required String message, String title = "Success"}) {
    show(
      title: title,
      message: message,
      contentType: ContentType.success,
    );
  }
  
  static void showWarning({required String message, String title = "Warning"}) {
    show(
      title: title,
      message: message,
      contentType: ContentType.warning,
    );
  }
}
