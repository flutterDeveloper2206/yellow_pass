import 'package:get/get.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/controller/cafe_book_controller.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/repository/cafe_book_repository.dart';

class CafeBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CafeBookRepository());
    Get.lazyPut(() => CafeBookController());
  }
}
