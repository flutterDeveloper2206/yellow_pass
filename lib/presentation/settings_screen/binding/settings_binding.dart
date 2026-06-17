import 'package:get/get.dart';
import '../../../../ApiServices/api_service.dart';
import '../controller/settings_controller.dart';
import '../repository/settings_repository.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => SettingsRepository());
    Get.lazyPut(() => SettingsController());
  }
}
