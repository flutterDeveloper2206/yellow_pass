import 'package:get/get.dart';
import '../controller/support_controller.dart';
import '../repository/support_repository.dart';
import '../../../../ApiServices/api_service.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => SupportRepository());
    Get.lazyPut(() => SupportController());
  }
}
