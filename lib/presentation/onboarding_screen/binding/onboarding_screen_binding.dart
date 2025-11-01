import 'package:yellow_pass/presentation/notification_screen/controller/notification_screen_controller.dart';
import 'package:get/get.dart';

import '../controller/onboarding_screen_controller.dart';

  class OnboardingScreenBinding extends Bindings {
  @override
  void dependencies() {   
    Get.lazyPut(() => OnboardingScreenController());
  }
}
