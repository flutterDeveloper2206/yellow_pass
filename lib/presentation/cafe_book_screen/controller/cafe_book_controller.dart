import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yellow_pass/data/models/availability_response_model.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';
import 'package:yellow_pass/data/models/table_type_response_model.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/repository/cafe_book_repository.dart';

class CafeBookController extends GetxController {
  final CafeBookRepository _repository = Get.find<CafeBookRepository>();

  RxInt selectedDateIndex = 0.obs;
  RxInt selectedTimeSlotIndex = (-1).obs;
  RxInt selectedTableTypeIndex = 0.obs;
  RxDouble duration = 1.0.obs;
  
  Rx<Cafe?> cafe = Rx<Cafe?>(null);
  RxBool isLoading = false.obs;
  RxBool isSlotsLoading = false.obs;

  RxList<DateTime> dateObjects = <DateTime>[].obs;
  RxList<TableType> tableTypes = <TableType>[].obs;
  RxList<String> timeSlots = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Cafe) {
      cafe.value = Get.arguments;
    } else if (Get.arguments is String) {
      // In case only ID is passed, we might need to fetch cafe details here too
      // but for now we assume Cafe object is passed
    }
    _generateInitialDates();
    if (cafe.value?.id != null) {
      fetchTableTypes();
    }
  }

  void _generateInitialDates() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 5; i++) {
      dateObjects.add(now.add(Duration(days: i)));
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateObjects[selectedDateIndex.value],
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.yellow.shade700,
              onPrimary: Colors.black,
              onSurface: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Check if already in list
      int index = dateObjects.indexWhere((d) => 
        d.year == picked.year && d.month == picked.month && d.day == picked.day);
      
      if (index != -1) {
        selectDate(index);
      } else {
        dateObjects.add(picked);
        // Sort dates
        dateObjects.sort((a, b) => a.compareTo(b));
        int newIndex = dateObjects.indexWhere((d) => 
          d.year == picked.year && d.month == picked.month && d.day == picked.day);
        selectDate(newIndex);
      }
    }
  }

  Future<void> fetchTableTypes() async {
    if (cafe.value?.id == null) {
      isLoading.value = false;
      return;
    }
    try {
      var response = await _repository.getTableTypes(cafe.value!.id!);
      if (response != null && response['status'] == true) {
        TableTypeResponse tableTypeResponse = TableTypeResponse.fromJson(response);
        if (tableTypeResponse.data != null) {
          tableTypes.value = tableTypeResponse.data!;
          if (tableTypes.isNotEmpty) {
            fetchAvailability();
          }
        }
      }
    } catch (e) {
      print("Error fetching table types: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAvailability() async {
    if (tableTypes.isEmpty || cafe.value == null) return;
    
    isSlotsLoading.value = true;
    selectedTimeSlotIndex.value = -1;
    timeSlots.clear();
    
    try {
      String date = DateFormat('yyyy-MM-dd').format(dateObjects[selectedDateIndex.value]);
      String tableTypeId = tableTypes[selectedTableTypeIndex.value].id!;
      int durationHours = duration.value.toInt();

      var response = await _repository.checkAvailability(
        cafeId: cafe.value!.id!,
        tableTypeId: tableTypeId,
        date: date,
        duration: durationHours,
      );

      if (response != null && response['status'] == true) {
        AvailabilityResponse availabilityResponse = AvailabilityResponse.fromJson(response);
        if (availabilityResponse.data != null && availabilityResponse.data!.slots != null) {
          timeSlots.value = availabilityResponse.data!.slots!;
        }
      }
    } catch (e) {
      print("Error checking availability: $e");
    } finally {
      isSlotsLoading.value = false;
    }
  }

  void selectDate(int index) {
    selectedDateIndex.value = index;
    fetchAvailability();
  }

  void selectTimeSlot(int index) {
    selectedTimeSlotIndex.value = index;
  }

  void selectTableType(int index) {
    selectedTableTypeIndex.value = index;
    fetchAvailability();
  }

  void updateDuration(double value) {
    duration.value = value;
    fetchAvailability();
  }

  String formatDateValue(DateTime date) => DateFormat('dd').format(date);
  String formatDayValue(DateTime date) => DateFormat('EEE').format(date);
  String formatMonthYear(DateTime date) => DateFormat('MMM, yyyy').format(date);
}
