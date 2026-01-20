import 'package:get/get.dart';
import '../../../ApiServices/api_service.dart';
import '../controller/menu_controller.dart';
import '../repository/menu_repository.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => MenuRepository());
    Get.lazyPut(() => MenuController());
  }
}
