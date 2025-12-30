import 'package:get/get.dart';
import 'package:yellow_pass/presentation/cafe_details_screen/controller/cafe_details_controller.dart';
import 'package:yellow_pass/presentation/cafe_details_screen/repository/cafe_details_repository.dart';
import '../../../ApiServices/api_service.dart';

class CafeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => CafeDetailsRepository());
    Get.lazyPut(() => CafeDetailsController());
  }
}
