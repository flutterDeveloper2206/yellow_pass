import 'package:get/get.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/repository/my_bookings_repository.dart';
import 'package:yellow_pass/data/models/user_booking_response_model.dart';
import 'package:yellow_pass/data/models/cancel_booking_response_model.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';

class MyBookingsController extends GetxController {
  final MyBookingsRepository _repository = Get.find<MyBookingsRepository>();

  RxInt selectedTabIndex = 0.obs; // 0: Upcoming, 1: Past
  RxBool isLoading = false.obs;
  
  RxList<UserBookingData> upcomingBookings = <UserBookingData>[].obs;
  RxList<UserBookingData> pastBookings = <UserBookingData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserBookings();
  }

  Future<void> fetchUserBookings() async {
    isLoading.value = true;
    try {
      var response = await _repository.getUserBookings();
      if (response != null && response['status'] == true) {
        UserBookingResponse bookingResponse = UserBookingResponse.fromJson(response);
        if (bookingResponse.data != null) {
          _processBookings(bookingResponse.data!);
        }
      } else {
        CommonSnackbar.showError(message: response?['message'] ?? "Failed to fetch bookings");
      }
    } catch (e) {
      print("Error fetching bookings: $e");
      CommonSnackbar.showError(message: "Something went wrong while fetching bookings");
    } finally {
      isLoading.value = false;
    }
  }

  void _processBookings(List<UserBookingData> allBookings) {
    upcomingBookings.clear();
    pastBookings.clear();
    
    for (var booking in allBookings) {
      if (booking.type == "upcoming") {
        upcomingBookings.add(booking);
      } else {
        pastBookings.add(booking);
      }
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> cancelBooking(UserBookingData booking) async {
    if (booking.id == null) return;
    
    try {
      var response = await _repository.cancelBooking(booking.id!);
      if (response != null) {
        CancelBookingResponse cancelResponse = CancelBookingResponse.fromJson(response);
        if (cancelResponse.status == true) {
          CommonSnackbar.showSuccess(message: cancelResponse.message ?? "Booking cancelled successfully");
          fetchUserBookings(); // Refresh the list
        } else {
          CommonSnackbar.showError(message: cancelResponse.message ?? "Failed to cancel booking");
        }
      }
    } catch (e) {
      print("Error cancelling booking: $e");
      CommonSnackbar.showError(message: "Something went wrong while cancelling the booking");
    }
  }

  Future<bool> submitReview({
    required String bookingId,
    required double rating,
    required String reviewText,
    required List<String> imagePaths,
  }) async {
    try {
      final fields = <String, String>{
        'booking_id': bookingId,
        'rating': rating.toInt().toString(),
        'review_text': reviewText,
      };

      final List<Map<String, String>> files = [];
      for (String path in imagePaths) {
        files.add({
          'field': 'photos[]',
          'path': path,
        });
      }

      var response = await _repository.submitReview(fields: fields, files: files);
      
      if (response != null) {
        // Assuming generic success response or parsing specific one
         if (response is Map && response['status'] == true) {
          CommonSnackbar.showSuccess(message: response['message'] ?? "Review submitted successfully");
          fetchUserBookings(); // Refresh to show the review
          return true;
        } else {
           CommonSnackbar.showError(message: response?['message'] ?? "Failed to submit review");
           return false;
        }
      }
      return false;
    } catch (e) {
      print("Error submitting review: $e");
      CommonSnackbar.showError(message: "Something went wrong while submitting review");
      return false;
    }
  }
}
