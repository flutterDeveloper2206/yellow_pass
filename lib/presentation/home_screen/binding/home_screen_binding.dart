import 'package:yellow_pass/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:get/get.dart';

  class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {   
    Get.lazyPut(() => HomeScreenController());
  }
}
