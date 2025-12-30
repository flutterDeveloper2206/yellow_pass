import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/presentation/verification_screen/repository/auth_repository.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/common_snackbar.dart';

class VerificationController extends GetxController {
  final AuthRepository _repository = Get.find<AuthRepository>();
  RxMap userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final data = SharedPrefs.getUser();
    if (data != null) {
      userData.value = data;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final response = await _repository.sendEmailOtp();
      if (response != null && response['status'] == true) {
        CommonSnackbar.showSuccess(message: response['message'] ?? "OTP sent successfully");
        Get.toNamed(AppRoutes.verifyOtpScreenRoute, arguments: {
          'type': 'email',
          'target': userData['email'],
        });
      }
    } catch (e) {
      debugPrint("Error sending email verification: $e");
    }
  }

  Future<void> sendMobileVerification() async {
    String? mobile = userData['mobile'];
    
    if (mobile == null || mobile.isEmpty) {
      // Navigate to enter mobile screen
      _showEnterMobileDialog();
      return;
    }

    try {
      final response = await _repository.sendMobileOtp(mobile);
      if (response != null && response['status'] == true) {
        CommonSnackbar.showSuccess(message: response['message'] ?? "OTP sent successfully");
        Get.toNamed(AppRoutes.verifyOtpScreenRoute, arguments: {
          'type': 'mobile',
          'target': mobile,
        });
      }
    } catch (e) {
      debugPrint("Error sending mobile verification: $e");
    }
  }

  void _showEnterMobileDialog() {
    final mobileController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text("Enter Mobile Number"),
        content: TextField(
          controller: mobileController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: "9876543210",
            labelText: "Mobile Number",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (mobileController.text.isNotEmpty) {
                Get.back();
                try {
                  final response = await _repository.sendMobileOtp(mobileController.text);
                  if (response != null && response['status'] == true) {
                    CommonSnackbar.showSuccess(message: response['message'] ?? "OTP sent successfully");
                    Get.toNamed(AppRoutes.verifyOtpScreenRoute, arguments: {
                      'type': 'mobile',
                      'target': mobileController.text,
                    });
                  }
                } catch (e) {
                  debugPrint("Error sending mobile verification: $e");
                }
              }
            },
            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }
}
