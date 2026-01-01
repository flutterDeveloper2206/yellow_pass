import 'package:get/get.dart';
import '../controller/my_booking_controller.dart';
import '../repository/my_booking_repository.dart';

class MyBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyBookingRepository());
    Get.lazyPut(() => MyBookingController());
  }
}
