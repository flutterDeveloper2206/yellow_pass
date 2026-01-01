import 'package:get/get.dart';
import '../controller/qr_scanner_controller.dart';
import '../../my_booking_screen/repository/my_booking_repository.dart';

class QrScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyBookingRepository());
    Get.lazyPut(() => QrScannerController());
  }
}
