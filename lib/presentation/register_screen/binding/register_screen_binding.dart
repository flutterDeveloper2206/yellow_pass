import 'package:yellow_pass/presentation/register_screen/controller/register_screen_controller.dart';
import 'package:get/get.dart';
import '../../../../ApiServices/api_service.dart';
import '../repository/register_repository.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => RegisterRepository());
    Get.lazyPut(() => RegisterScreenController());
  }
}
