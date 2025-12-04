

import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  RxBool isProfileVisible = true.obs;

  void toggleProfileVisibility(bool value) {
    isProfileVisible.value = value;
  }
}
