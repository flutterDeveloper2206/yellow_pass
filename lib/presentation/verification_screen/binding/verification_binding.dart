import 'package:get/get.dart';
import 'package:yellow_pass/presentation/verification_screen/repository/auth_repository.dart';
import 'package:yellow_pass/presentation/verification_screen/controller/verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => VerificationController());
  }
}
