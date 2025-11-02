import 'dart:async';

import 'package:get/get.dart';
import 'package:yellow_pass/routes/app_routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 4),
        () => Get.toNamed(AppRoutes.onBoardingRoute));
    super.onInit();
  }

}
