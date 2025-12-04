import 'package:get/get.dart';

class CheckInSuccessController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Simulate auto-connecting to WiFi
    Future.delayed(const Duration(seconds: 2), () {
      // You can show a snackbar or update UI state here
      Get.snackbar("WiFi Connected", "Successfully connected to Cafe WiFi");
    });
  }

  void onContinue() {
    Get.offNamedUntil('/my_booking_screen', (route) => route.isFirst);
  }
}
