import 'package:yellow_pass/presentation/dashboard_screen/controller/dashboard_screen_controller.dart';
import 'package:get/get.dart';
import '../../../ApiServices/api_service.dart';
import '../repository/dashboard_repository.dart';

  class DashboardScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => DashboardRepository());
    Get.lazyPut(() => DashboardScreenController());
  }
}
