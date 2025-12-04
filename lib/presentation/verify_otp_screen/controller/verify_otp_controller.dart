import 'dart:async';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  RxString otp = "".obs;
  RxInt timer = 12.obs; // 12 seconds for demo
  Timer? _timer;
  
  // Arguments
  late String verificationType; // 'email' or 'mobile'
  late String target;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    verificationType = args['type'] ?? 'email';
    target = args['target'] ?? '';
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    timer.value = 12;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode() {
    startTimer();
    // Logic to resend OTP
  }

  void verifyOtp() {
    // Mock verification logic
    if (otp.value.length == 4) {
      if (otp.value == "1234") {
        // Success
        Get.back(result: true); // Or show success dialog here
      } else {
        // Failure
        Get.back(result: false); // Or show error dialog here
      }
    }
  }
}
