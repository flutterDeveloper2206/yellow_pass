import 'package:get/get.dart';
import 'package:yellow_pass/presentation/notification_screen/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}
