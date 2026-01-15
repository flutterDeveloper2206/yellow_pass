import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../my_booking_screen/repository/my_booking_repository.dart';
import 'package:yellow_pass/data/models/user_booking_response_model.dart';
import 'package:yellow_pass/data/models/check_in_response_model.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';

class CheckInOtpController extends GetxController {
  final MyBookingRepository _repository = Get.find<MyBookingRepository>();
  
  UserBookingData? booking;
  bool isCheckOut = false;
  RxString otp = "".obs;
  RxBool isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is UserBookingData) {
      booking = Get.arguments;
    } else if (Get.arguments is Map) {
      booking = Get.arguments['booking'];
      isCheckOut = Get.arguments['isCheckOut'] ?? false;
    }
  }

  Future<void> verifyOtp() async {
    if (booking == null) {
      CommonSnackbar.showError(message: "Booking data missing");
      return;
    }

    if (otp.value.length < 4) {
      CommonSnackbar.showError(message: "Please enter a valid OTP");
      return;
    }

    if (isProcessing.value) return;
    isProcessing.value = true;

    try {
      Map<String, dynamic> body = {
        "booking_id": booking!.id,
        "otp": otp.value
      };

      var response = isCheckOut 
          ? await _repository.checkOut(body)
          : await _repository.checkIn(body);
          
      if (response != null) {
        bool isSuccess = response['status'] == true;
        
        Get.offNamed(
          AppRoutes.checkInSuccessScreenRoute, 
          arguments: {
            'isSuccess': isSuccess,
            'title': isSuccess 
                ? (isCheckOut ? 'Check-out Successful!' : 'Check-in Successful!') 
                : (isCheckOut ? 'Check-out Failed' : 'Check-in Failed'),
            'message': response['message'],
            'cafeName': booking?.cafe?.name ?? "the Cafe"
          }
        );
      } else {
        CommonSnackbar.showError(message: "${isCheckOut ? 'Check-out' : 'Check-in'} failed. Please try again.");
      }
    } catch (e) {
      print("${isCheckOut ? 'Check-out' : 'Check-in'} error: $e");
      CommonSnackbar.showError(message: "Something went wrong during ${isCheckOut ? 'check-out' : 'check-in'}");
    } finally {
      isProcessing.value = false;
    }
  }
}
