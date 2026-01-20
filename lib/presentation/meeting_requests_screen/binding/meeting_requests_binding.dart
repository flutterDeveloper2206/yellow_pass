import 'package:get/get.dart';
import '../controller/meeting_requests_controller.dart';

class MeetingRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MeetingRequestsController());
  }
}
