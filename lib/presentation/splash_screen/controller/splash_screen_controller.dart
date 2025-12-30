import 'dart:async';

import 'package:get/get.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import '../../../../core/utils/shared_prefs.dart';
class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Wait for a moment to show splash (optional)
    await Future.delayed(const Duration(seconds: 3));

    // Initialize prefs
    await SharedPrefs.init();

    if (SharedPrefs.isLoggedIn()) {
      Get.offNamed(AppRoutes.dashboardScreenRoute);
    } else {
      Get.offNamed(AppRoutes.loginScreenRoute); // or onBoardingRoute
    }
  }
}