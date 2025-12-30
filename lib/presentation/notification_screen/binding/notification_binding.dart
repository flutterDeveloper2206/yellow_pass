import 'package:get/get.dart';
import 'package:yellow_pass/presentation/notification_screen/controller/notification_controller.dart';
import 'package:yellow_pass/presentation/notification_screen/repository/notification_repository.dart';
import '../../../ApiServices/api_service.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => NotificationRepository());
    Get.lazyPut(() => NotificationController());
  }
}
