import 'package:get/get.dart';
import '../controller/qr_scanner_controller.dart';

class QrScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrScannerController());
  }
}
