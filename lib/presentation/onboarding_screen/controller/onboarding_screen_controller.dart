import 'package:yellow_pass/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class OnboardingScreenController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  List<Map<String, String>> onboardingPages = [
    {
      'image': ImageConstant.imgOnBoard1,
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

  bool get isLastPage => currentPage.value == onboardingPages.length - 1;

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goToLogin() {
    Get.offAllNamed(AppRoutes.loginScreenRoute);
  }
}
