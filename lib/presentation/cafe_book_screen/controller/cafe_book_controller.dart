import 'package:get/get.dart';

class CafeBookController extends GetxController {
  RxInt selectedDateIndex = 0.obs;
  RxInt selectedTimeSlotIndex = 0.obs;
  RxInt selectedTableSizeIndex = 0.obs;
  RxDouble duration = 1.0.obs;

  final List<String> dates = ['11', '12', '13', '14', '15'];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  
  final List<String> timeSlots = ['11:00 am', '12:45 pm', '3:00 pm', '6:15 pm'];
  
  final List<String> tableSizes = ['Table of 2', 'Table of 4', 'Meeting Room'];

  void selectDate(int index) {
    selectedDateIndex.value = index;
  }

  void selectTimeSlot(int index) {
    selectedTimeSlotIndex.value = index;
  }

  void selectTableSize(int index) {
    selectedTableSizeIndex.value = index;
  }

  void updateDuration(double value) {
    duration.value = value;
  }
}
