import 'package:yellow_pass/presentation/profile_screen/controller/profile_screen_controller.dart';
import 'package:get/get.dart';

  class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {   
    Get.lazyPut(() => ProfileScreenController());
  }
}
