import 'package:yellow_pass/presentation/network_screen/controller/network_screen_controller.dart';
import 'package:get/get.dart';

  class NetworkScreenBinding extends Bindings {
  @override
  void dependencies() {   
    Get.lazyPut(() => NetworkScreenController());
  }
}
