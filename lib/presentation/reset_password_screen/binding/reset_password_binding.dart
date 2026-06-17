import 'package:get/get.dart';
import '../../../../ApiServices/api_service.dart';
import '../../login_screen/repository/login_repository.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => LoginRepository());
    Get.lazyPut(() => ResetPasswordController());
  }
}
