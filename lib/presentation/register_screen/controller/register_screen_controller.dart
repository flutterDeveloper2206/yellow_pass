import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/common_snackbar.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../repository/register_repository.dart';

class RegisterScreenController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralCodeController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;



  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final referralCode = referralCodeController.text.trim();

    if (name.isEmpty) {
      CommonSnackbar.showError(message: "Please enter your full name");
      return;
    }
    if (name.length < 3) {
      CommonSnackbar.showError(message: "Name must be at least 3 characters");
      return;
    }
    if (email.isEmpty) {
      CommonSnackbar.showError(message: "Please enter your email");
      return;
    }
    if (!GetUtils.isEmail(email)) {
      CommonSnackbar.showError(message: "Please enter a valid email address");
      return;
    }
    if (password.isEmpty) {
      CommonSnackbar.showError(message: "Please enter a password");
      return;
    }
    if (password.length < 6) {
      CommonSnackbar.showError(message: "Password must be at least 6 characters");
      return;
    }
    if (confirmPassword.isEmpty) {
      CommonSnackbar.showError(message: "Please confirm your password");
      return;
    }
    if (password != confirmPassword) {
      CommonSnackbar.showError(message: "Passwords do not match");
      return;
    }

    try {
      final registerRepository = Get.find<RegisterRepository>();
      final Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
      };
      if (referralCode.isNotEmpty) {
        body["referral_code"] = referralCode;
      }

      final dynamic response = await registerRepository.registerUser(body);

      if (response != null && response is Map) {
        if (response['status'] == true || response['status_code'] == 201) {
          final userData = response['data']['user'];
          final token = response['data']['token'];

          if (token != null) {
            await SharedPrefs.setToken(token);
            if (userData != null) {
              await SharedPrefs.setUser(userData);
            }

            CommonSnackbar.showSuccess(
              title: "Success",
              message: response['message'] ?? "User registered successfully!",
            );

            Get.offAllNamed(AppRoutes.dashboardScreenRoute);
          } else {
            throw Exception("Token not found in response");
          }
        } else {
          throw Exception(response['message'] ?? "Registration failed");
        }
      }
    } catch (e, stack) {
      debugPrint("Registration Error: $e\n$stack");
      CommonSnackbar.showError(
        title: "Registration Failed",
        message: e.toString().replaceAll("Exception: ", ""),
      );
    }
  }
}
