import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/common_snackbar.dart';
import '../../../routes/app_routes.dart';
import '../../login_screen/repository/login_repository.dart';

class ResetPasswordController extends GetxController {
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  late String email;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    email = args['email'] ?? '';
  }



  Future<void> resetPassword() async {
    final token = otpController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (token.isEmpty) {
      CommonSnackbar.showError(message: "Please enter the 6-digit OTP code");
      return;
    }
    if (token.length != 6) {
      CommonSnackbar.showError(message: "OTP code must be exactly 6 digits");
      return;
    }
    if (password.isEmpty) {
      CommonSnackbar.showError(message: "Please enter a new password");
      return;
    }
    if (password.length < 6) {
      CommonSnackbar.showError(message: "Password must be at least 6 characters");
      return;
    }
    if (confirmPassword.isEmpty) {
      CommonSnackbar.showError(message: "Please confirm your new password");
      return;
    }
    if (password != confirmPassword) {
      CommonSnackbar.showError(message: "Passwords do not match");
      return;
    }

    try {
      final repository = Get.find<LoginRepository>();
      final Map<String, dynamic> body = {
        "email": email,
        "token": token,
        "password": password,
        "password_confirmation": confirmPassword,
      };

      final dynamic response = await repository.resetPassword(body);

      if (response != null && response is Map) {
        if (response['status'] == true) {
          CommonSnackbar.showSuccess(
            title: "Success",
            message: response['message'] ?? "Your password has been reset successfully.",
          );
          
          Get.offAllNamed(AppRoutes.loginScreenRoute);
        } else {
          throw Exception(response['message'] ?? "Failed to reset password");
        }
      }
    } catch (e, stack) {
      debugPrint("ResetPassword Error: $e\n$stack");
      CommonSnackbar.showError(
        title: "Reset Password Failed",
        message: e.toString().replaceAll("Exception: ", ""),
      );
    }
  }
}
