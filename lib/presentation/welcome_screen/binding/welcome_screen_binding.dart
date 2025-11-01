import 'package:get/get.dart';
import 'package:yellow_pass/presentation/welcome_screen/controller/welcome_screen_controller.dart';

class WelComeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelComeScreenController());
  }
}
