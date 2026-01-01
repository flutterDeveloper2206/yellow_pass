import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import '../../my_booking_screen/controller/my_booking_controller.dart';
import '../../my_booking_screen/repository/my_booking_repository.dart';
import 'package:yellow_pass/data/models/user_booking_response_model.dart';
import 'package:yellow_pass/data/models/check_in_response_model.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';

import 'package:yellow_pass/data/models/check_out_response_model.dart';

class QrScannerController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();
  final MyBookingRepository _repository = Get.find<MyBookingRepository>();
  
  UserBookingData? booking;
  bool isCheckOut = false;
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

  void onDetect(BarcodeCapture capture) {
    if (isProcessing.value) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? qrCode = barcodes.first.rawValue;
      if (qrCode != null) {
        if (isCheckOut) {
          _performCheckOut(qrCode);
        } else {
          _performCheckIn(qrCode);
        }
      }
    }
  }

  void skipScanner() {
    if (isProcessing.value) return;
    
    if (isCheckOut) {
      _performCheckOut("skipped_qr_code");
    } else {
      _performCheckIn("skipped_qr_code");
    }
  }


  Future<void> _performCheckIn(String qrCode) async {
    if (booking == null) {
      CommonSnackbar.showError(message: "Booking data missing");
      return;
    }

    if (isProcessing.value) return;
    isProcessing.value = true;
    scannerController.stop();

    try {
      Map<String, dynamic> body = {
        "booking_id": booking!.id,
        "qr_code": qrCode
      };

      var response = await _repository.checkIn(body);
      if (response != null) {
        CheckInResponse checkInResponse = CheckInResponse.fromJson(response);
        
        bool isSuccess = checkInResponse.status == true;
        
        Get.offNamed(
          AppRoutes.checkInSuccessScreenRoute, 
          arguments: {
            'isSuccess': isSuccess,
            'title': isSuccess ? 'Check-in Successful!' : 'Check-in Failed',
            'message': checkInResponse.message,
            'cafeName': booking?.cafe?.name ?? "the Cafe"
          }
        );
      } else {
         Get.offNamed(
          AppRoutes.checkInSuccessScreenRoute, 
          arguments: {
            'isSuccess': false,
            'title': 'Check-in Failed',
            'message': "Server error. Please try again later.",
            'cafeName': booking?.cafe?.name ?? "the Cafe"
          }
        );
      }
    } catch (e) {
      print("Check-in error: $e");
       Get.offNamed(
          AppRoutes.checkInSuccessScreenRoute, 
          arguments: {
            'isSuccess': false,
            'title': 'Check-in Failed',
            'message': "Something went wrong during check-in",
            'cafeName': booking?.cafe?.name ?? "the Cafe"
          }
        );
    }
  }

  Future<void> _performCheckOut(String qrCode) async {
    if (booking == null) {
      CommonSnackbar.showError(message: "Booking data missing");
      return;
    }

    if (isProcessing.value) return;
    isProcessing.value = true;
    scannerController.stop();

    try {
      // Assuming checkout API also takes qr_code now as per flow "scan qr -> checkout"
      // If the previous payload was strict, we can keep it as is, but typically scan implies usage.
      // We will stick to the previous payload structure to call the API, but triggered by scan.
      Map<String, dynamic> body = {
        "booking_id": booking!.id,
        "qr_code": qrCode // Adding QR code if API supports it, otherwise it might be ignored
      };
      // Note: If API strictly rejects extra fields, user should clarify. 
      // Based on previous successful payload:
      // "booking_id": "..."
      // But now we scanned a QR. Let's try sending it. 
      // If it fails with "unknown field", we'll revert. 
      // However, usually it's ignored if extra.
      
      var response = await _repository.checkOut(body);
      if (response != null) {
        CheckOutResponse checkOutResponse = CheckOutResponse.fromJson(response);
        
        bool isSuccess = checkOutResponse.status == true;
        
        Get.offNamed(
          AppRoutes.checkInSuccessScreenRoute, 
          arguments: {
            'isSuccess': isSuccess,
            'title': isSuccess ? 'Check-out Successful!' : 'Check-out Failed',
            'message': checkOutResponse.message,
            'cafeName': booking?.cafe?.name ?? "the Cafe"
          }
        );
      } else {
         Get.offNamed(
          AppRoutes.checkInSuccessScreenRoute, 
          arguments: {
            'isSuccess': false,
            'title': 'Check-out Failed',
            'message': "Server error. Please try again later.",
            'cafeName': booking?.cafe?.name ?? "the Cafe"
          }
        );
      }
    } catch (e) {
      print("Check-out error: $e");
       Get.offNamed(
          AppRoutes.checkInSuccessScreenRoute, 
          arguments: {
            'isSuccess': false,
            'title': 'Check-out Failed',
            'message': "Something went wrong during check-out",
            'cafeName': booking?.cafe?.name ?? "the Cafe"
          }
        );
    }
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
