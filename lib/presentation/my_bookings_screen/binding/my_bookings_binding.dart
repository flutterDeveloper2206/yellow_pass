import 'package:get/get.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/controller/my_bookings_controller.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/repository/my_bookings_repository.dart';

class MyBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyBookingsRepository());
    Get.lazyPut(() => MyBookingsController());
  }
}
