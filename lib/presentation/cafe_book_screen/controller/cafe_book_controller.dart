import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yellow_pass/data/models/availability_response_model.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';
import 'package:yellow_pass/data/models/table_type_response_model.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/repository/cafe_book_repository.dart';
import 'package:yellow_pass/core/utils/shared_prefs.dart';
import 'package:yellow_pass/data/models/booking_request_model.dart';
import 'package:yellow_pass/data/models/booking_response_model.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';

class CafeBookController extends GetxController {
  final CafeBookRepository _repository = Get.find<CafeBookRepository>();

  RxInt selectedDateIndex = 0.obs;
  RxInt selectedTimeSlotIndex = (-1).obs;
  RxInt selectedTableTypeIndex = 0.obs;
  RxDouble duration = 1.0.obs;
  
  final TextEditingController specialRequestsController = TextEditingController();
  
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
    duration.value=1.0;
    fetchAvailability();
  }

  void updateDuration(double value) {
    duration.value = value;
    fetchAvailability();
  }

  String formatDateValue(DateTime date) => DateFormat('dd').format(date);
  String formatDayValue(DateTime date) => DateFormat('EEE').format(date);
  String formatMonthYear(DateTime date) => DateFormat('MMM, yyyy').format(date);

  Future<void> bookCafe() async {
    if (cafe.value == null || tableTypes.isEmpty || selectedTimeSlotIndex.value == -1) {
      CommonSnackbar.showError(message: "Please select all details");
      return;
    }

    try {
      final user = SharedPrefs.getUser();
      if (user == null) {
        CommonSnackbar.showError(message: "User not found, please login again");
        return;
      }

      String dateStr = DateFormat('yyyy-MM-dd').format(dateObjects[selectedDateIndex.value]);
      String startTimeSlot = timeSlots[selectedTimeSlotIndex.value];
      
      // Parse token cost
      int hourlyRate = 200; // default
      if (cafe.value?.pricePerHour != null) {
        hourlyRate = int.tryParse(cafe.value!.pricePerHour!) ?? 200;
      }
      int totalTokenCost = (hourlyRate * duration.value).toInt();

      // Format start and end time
      // Assume startTimeSlot is like "10:00 AM" or "10:00:00"
      // Looking at availability_response, slots are just strings.
      // API example shows "2026-01-01 10:00:00"
      
      String startTime = _formatDateTime(dateStr, startTimeSlot);
      
      // For end time, add duration
      DateTime startDT = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startTime);
      DateTime endDT = startDT.add(Duration(hours: duration.value.toInt()));
      String endTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(endDT);

      BookingRequest request = BookingRequest(
        cafeId: cafe.value!.id,
        tableTypeId: tableTypes[selectedTableTypeIndex.value].id,
        userId: user['id'].toString(),
        startTime: startTime,
        endTime: endTime,
        tokenCost: totalTokenCost,
        specialRequests: specialRequestsController.text,
      );

      var response = await _repository.bookCafe(request.toJson());

      if (response != null) {
        BookingResponse bookingResponse = BookingResponse.fromJson(response);
        if (bookingResponse.status == true) {
          CommonSnackbar.showSuccess(message: bookingResponse.message ?? "Cafe booking successfully");
          Get.back(); // Close dialog if open
          Get.back(); // Go back to details or previous screen
        } else {
          CommonSnackbar.showError(message: bookingResponse.message ?? "Insufficient tokens");
        }
      }
    } catch (e) {
      print("Error booking cafe: $e");
      CommonSnackbar.showError(message: "Something went wrong");
    }
  }

  String _formatDateTime(String date, String timeSlot) {
    // timeSlot could be "10:00 AM" or "10:00"
    // Let's try to parse it safely
    try {
      DateTime parsedTime = DateFormat.jm().parse(timeSlot); // "10:00 AM"
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      return "$date $formattedTime";
    } catch (e) {
      try {
        DateTime parsedTime = DateFormat('HH:mm').parse(timeSlot); // "10:00"
        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
        return "$date $formattedTime";
      } catch (e2) {
        // Fallback or handle differently
        return "$date $timeSlot:00";
      }
    }
  }

  @override
  void onClose() {
    specialRequestsController.dispose();
    super.onClose();
  }
}
