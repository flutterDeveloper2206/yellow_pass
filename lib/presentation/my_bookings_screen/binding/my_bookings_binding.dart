import 'package:get/get.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/controller/my_bookings_controller.dart';

class MyBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyBookingsController());
  }
}
