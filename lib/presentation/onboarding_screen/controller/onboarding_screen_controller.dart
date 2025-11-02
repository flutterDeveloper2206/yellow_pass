import 'package:yellow_pass/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class OnboardingScreenController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  List<Map<String, String>> pages = [
    {
      'image': ImageConstant.imgSplashBg,
      'title': 'Welcome to Cazipro',
      'subtitle': 'Your smart partner for professional growth.',
    },
    {
      'image': ImageConstant.imgOnBoard2,
      'title': 'Connect & Collaborate',
      'subtitle': 'Build connections that matter to your success.',
    },
    {
      'image': ImageConstant.imgOnBoard3,
      'title': 'Grow with Insights',
      'subtitle': 'Learn, adapt, and grow your business with data.',
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }



  void goToLogin() {
    Get.offAllNamed(AppRoutes.loginScreenRoute);
  }

  void nextPage() {
    if (currentPage.value == pages.length - 1) {
      // Last page → Go to Login Screen
     goToLogin();
    } else {
      // Move to next page
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


}
