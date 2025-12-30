import 'package:yellow_pass/ApiServices/api_service.dart';
import 'package:yellow_pass/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:get/get.dart';
import '../repository/home_repository.dart';

  class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());

    Get.lazyPut(() => HomeRepository());
    Get.lazyPut(() => HomeScreenController());
  }
}
