import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import 'package:linkedin_login/linkedin_login.dart';
import '../../../widgets/common_snackbar.dart';
import '../linkedin_auth_screen.dart';
import '../repository/login_repository.dart';
import '../../../../core/utils/shared_prefs.dart';

class LoginScreenController extends GetxController {
  final referralCodeController = TextEditingController();
  final isReferralView = false.obs;

  @override
  void onClose() {
    referralCodeController.dispose();
    super.onClose();
  }


  Future<void> goToLogin() async {
    try {
      if (kDebugMode) {
        final debugLoginData = {
          "sub": "0",
          "email": "kishup713@gmail.com",
          "name": "Kishan Dobariya",
          "picture": "https://media.licdn.com/dms/image/v2/D4D03AQETljiaulXH1g/profile-displayphoto-scale_200_200/B4DZgE.HhpGQAg-/0/1752430051473?e=1775088000&v=beta&t=mMejhePxvwUMLGfZWal-cmBMfoYLGXPcWcuBJmxrLhM",
          "email_verified": true,
        };
        await _handleLoginProcess(debugLoginData);
        return;
      }

      final result = await Get.to(() => const LinkedInAuthScreen());

      if (result is UserSucceededAction) {
        final user = result.user;
        final loginData = {
          "sub": '0', // Fallback to email if sub is missing (safe bet)
          "email": user.email ?? '',
          "name": user.name ?? '',
          "picture": user.picture ?? '',
          "email_verified": user.isEmailVerified ?? false,
        };
        await _handleLoginProcess(loginData);
      } else if (result is UserFailedAction) {
        CommonSnackbar.showError(
          title: "Login Failed",
          message: result.toString(),
        );
      }
    } catch (e) {
      debugPrint("Login Error: $e");
      CommonSnackbar.showError(message: "An unexpected error occurred: $e");
    }
  }

  Future<void> _handleLoginProcess(Map<String, dynamic> loginData) async {
    try {
      final loginRepository = Get.find<LoginRepository>();
      final dynamic apiResponse = await loginRepository.mobileLogin(loginData);

      if (apiResponse != null) {
        final data = apiResponse;

        if (data is Map && data['status'] == true) {
          final userData = data['data']['user'];
          final token = data['data']['token'];

          if (token != null) {
            await SharedPrefs.setToken(token);
            if (userData != null) {
              await SharedPrefs.setUser(userData);
            }

            CommonSnackbar.showSuccess(
              title: "Welcome",
              message: "Logged in successfully!",
            );

            // Navigate to dashboard
            Get.offAllNamed(AppRoutes.dashboardScreenRoute);
          } else {
            throw Exception("Token not found in response");
          }
        } else {
          throw Exception(data['message'] ?? "API returned status false or invalid format");
        }
      } else {
        throw Exception("API response was null");
      }
    } catch (apiError) {
      CommonSnackbar.showError(
        title: "Authentication Failed",
        message: apiError.toString().replaceAll("Exception: ", ""),
      );
    }
  }

  void toggleReferralView() {
    isReferralView.value = !isReferralView.value;
  }

  void proceedWithReferral() {
    // Implement referral logic here
    Get.snackbar("Success", "Referral code applied!");
    goToLogin();
  }
}
