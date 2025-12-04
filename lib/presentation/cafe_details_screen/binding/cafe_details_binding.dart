import 'package:get/get.dart';
import 'package:yellow_pass/presentation/cafe_details_screen/controller/cafe_details_controller.dart';

class CafeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CafeDetailsController());
  }
}
