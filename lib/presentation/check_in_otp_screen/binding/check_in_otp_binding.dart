import 'package:get/get.dart';
import '../controller/check_in_otp_controller.dart';
import '../../my_booking_screen/repository/my_booking_repository.dart';

class CheckInOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyBookingRepository());
    Get.lazyPut(() => CheckInOtpController());
  }
}
