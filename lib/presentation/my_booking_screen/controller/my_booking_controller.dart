import 'package:get/get.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/data/models/user_booking_response_model.dart';
import '../repository/my_booking_repository.dart';
import 'package:yellow_pass/data/models/check_in_response_model.dart';
import 'package:yellow_pass/data/models/check_out_response_model.dart';
import 'package:yellow_pass/data/models/booking_detail_response_model.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';

class MyBookingController extends GetxController {
  final MyBookingRepository _repository = Get.find<MyBookingRepository>();
  RxBool isLoading = false.obs;
  RxBool isCheckedIn = false.obs;
  RxBool isCheckingOut = false.obs;
  Rx<DetailedBooking?> bookingDetails = Rx<DetailedBooking?>(null);
  Rx<UserBookingData?> booking = Rx<UserBookingData?>(null);
  

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is UserBookingData) {
      booking.value = Get.arguments;
      fetchBookingDetails();
    }
  }

  Future<void> fetchBookingDetails() async {
    if (booking.value?.id == null) return;
    
    isLoading.value = true;
    try {
      var response = await _repository.getBookingDetails(booking.value!.id!);
      if (response != null) {
        BookingDetailResponse detailResponse = BookingDetailResponse.fromJson(response);
        if (detailResponse.status == true) {
          bookingDetails.value = detailResponse.data?.booking;
          if (bookingDetails.value?.checkInStatus == "checked_in") {
            isCheckedIn.value = true;
          } else {
            isCheckedIn.value = false;
          }
        }
      }
    } catch (e) {
      print("Error fetching booking details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void checkIn() {
    if (bookingDetails.value == null) return;
    Get.toNamed(AppRoutes.checkInOtpScreenRoute, arguments: {
      'booking': booking.value, 
      'isCheckOut': false
    })?.then((_) => fetchBookingDetails());
  }

  void checkOut() {
    if (booking.value == null) return;
    Get.toNamed(AppRoutes.checkInOtpScreenRoute, arguments: {
      'booking': booking.value, 
      'isCheckOut': true
    })?.then((_) => fetchBookingDetails());
  }
  
  void setCheckedIn() {
      isCheckedIn.value = true;
  }
}
