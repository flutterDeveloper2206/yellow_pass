import 'package:get/get.dart';
import '../controller/other_profile_controller.dart';
import '../../../ApiServices/api_service.dart';

class OtherProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtherProfileController());
    Get.lazyPut(() => ApiService());
  }
}
