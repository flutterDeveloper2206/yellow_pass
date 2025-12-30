import 'package:get/get.dart';
import 'package:yellow_pass/presentation/verify_otp_screen/controller/verify_otp_controller.dart';
import '../../verification_screen/repository/auth_repository.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => VerifyOtpController());
  }
}
