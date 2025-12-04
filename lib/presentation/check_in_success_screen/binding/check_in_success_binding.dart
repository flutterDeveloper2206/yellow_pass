import 'package:get/get.dart';
import '../controller/check_in_success_controller.dart';

class CheckInSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckInSuccessController());
  }
}
