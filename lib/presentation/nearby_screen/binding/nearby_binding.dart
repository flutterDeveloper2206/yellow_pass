import 'package:get/get.dart';
import '../controller/nearby_controller.dart';
import '../repository/nearby_repository.dart';

class NearbyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NearbyRepository());
    Get.lazyPut(() => NearbyController());
  }
}
