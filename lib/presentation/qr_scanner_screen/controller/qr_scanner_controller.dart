import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../my_booking_screen/controller/my_booking_controller.dart';

class QrScannerController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();
  
  void onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      // Assuming any QR code is valid for demo purposes
      scannerController.stop();
      
      // Update check-in status in MyBookingController
      if (Get.isRegistered<MyBookingController>()) {
        Get.find<MyBookingController>().setCheckedIn();
      }
      
      Get.offNamed('/check_in_success_screen');
    }
  }

  void skipScanner(){
    scannerController.stop();
      
      // Update check-in status in MyBookingController
      if (Get.isRegistered<MyBookingController>()) {
        Get.find<MyBookingController>().setCheckedIn();
      }
      
      Get.offNamed('/check_in_success_screen');
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
