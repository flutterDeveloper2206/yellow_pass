import 'package:get/get.dart';
import '../../../../ApiServices/api_service.dart';
import '../../login_screen/repository/login_repository.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => LoginRepository());
    Get.lazyPut(() => ForgotPasswordController());
  }
}
