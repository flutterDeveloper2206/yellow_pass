import 'package:get/get.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/controller/cafe_book_controller.dart';

class CafeBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CafeBookController());
  }
}
