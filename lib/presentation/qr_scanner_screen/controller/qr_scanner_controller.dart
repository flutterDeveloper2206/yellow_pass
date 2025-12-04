import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import '../../my_booking_screen/controller/my_booking_controller.dart';

class QrScannerController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();
  
  void onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      // Assuming any QR code is valid for demo purposes
      // scannerController.stop(); // Removed to avoid conflict with dispose
      
      // Update check-in status in MyBookingController
      if (Get.isRegistered<MyBookingController>()) {
        Get.find<MyBookingController>().setCheckedIn();
      }
      
      Get.offNamed(AppRoutes.checkInSuccessScreenRoute);
    }
  }

  void skipScanner(){
    // scannerController.stop(); // Removed to avoid conflict with dispose
      
      // Update check-in status in MyBookingController
      if (Get.isRegistered<MyBookingController>()) {
        Get.find<MyBookingController>().setCheckedIn();
      }
      
      Get.offNamed(AppRoutes.checkInSuccessScreenRoute);
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
