import 'package:get/get.dart';

class CafeDetailsController extends GetxController {
  final RxList<String> images = [
    'https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop',
  ].obs;
  RxInt currentImageIndex = 0.obs;

  void updateImageIndex(int index) {
    currentImageIndex.value = index;
  }

  final List<String> dates = ['11', '12', '13', '14', '15'];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final List<String> timeSlots = ['11:00 am', '12:45 pm', '3:00 pm', '6:15 pm'];
  final List<String> tableSizes = ['Table of 2', 'Table of 4', 'Meeting Room'];
}
