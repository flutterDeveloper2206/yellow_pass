import 'package:get/get.dart';
import '../../../ApiServices/api_service.dart';
import '../controller/my_orders_controller.dart';
import '../repository/my_orders_repository.dart';

class MyOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => MyOrdersRepository());
    Get.lazyPut(() => MyOrdersController());
  }
}
