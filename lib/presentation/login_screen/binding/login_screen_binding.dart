import 'package:yellow_pass/presentation/login_screen/controller/login_screen_controller.dart';
import 'package:get/get.dart';
import '../../../ApiServices/api_service.dart';
import '../repository/login_repository.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => LoginRepository());
    Get.lazyPut(() => LoginScreenController());
  }
}
