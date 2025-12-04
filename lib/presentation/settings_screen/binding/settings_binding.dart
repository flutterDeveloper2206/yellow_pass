import 'package:get/get.dart';
import 'package:yellow_pass/presentation/settings_screen/controller/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
