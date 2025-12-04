import 'package:get/get.dart';
import 'package:yellow_pass/presentation/profile_details_screen/controller/profile_details_controller.dart';

class ProfileDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileDetailsController());
  }
}
