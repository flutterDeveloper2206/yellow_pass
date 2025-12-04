import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class LoginScreenController extends GetxController {
  final referralCodeController = TextEditingController();
  final isReferralView = false.obs;

  @override
  void onClose() {
    referralCodeController.dispose();
    super.onClose();
  }

  void goToLogin() {
    // Check if user is logging in for the first time
    // In a real app, this would check SharedPreferences or backend
    final isFirstTime = true; // Change this based on your logic
    
    if (isFirstTime) {
      // Navigate to verification screen for first-time users
      Get.toNamed(AppRoutes.verificationScreenRoute);
    } else {
      // Navigate directly to dashboard for returning users
      Get.toNamed(AppRoutes.dashboardScreenRoute);
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
