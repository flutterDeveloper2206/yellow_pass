import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/common_snackbar.dart';
import '../../../routes/app_routes.dart';
import '../../login_screen/repository/login_repository.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map && Get.arguments['email'] != null) {
      emailController.text = Get.arguments['email'].toString();
    }
  }



  Future<void> sendOtp() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      CommonSnackbar.showError(message: "Please enter your email");
      return;
    }
    if (!GetUtils.isEmail(email)) {
      CommonSnackbar.showError(message: "Please enter a valid email address");
      return;
    }

    try {
      final repository = Get.find<LoginRepository>();
      final Map<String, dynamic> body = {"email": email};

      final dynamic response = await repository.forgotPassword(body);

      if (response != null && response is Map) {
        if (response['status'] == true) {
          CommonSnackbar.showSuccess(
            title: "OTP Sent",
            message: response['message'] ?? "Password reset OTP sent successfully.",
          );
          
          Get.toNamed(
            AppRoutes.resetPasswordScreenRoute,
            arguments: {"email": email},
          );
        } else {
          throw Exception(response['message'] ?? "Failed to send OTP");
        }
      }
    } catch (e, stack) {
      debugPrint("ForgotPassword Error: $e\n$stack");
      CommonSnackbar.showError(
        title: "Request Failed",
        message: e.toString().replaceAll("Exception: ", ""),
      );
    }
  }
}
