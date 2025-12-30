import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/presentation/verification_screen/repository/auth_repository.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../dashboard_screen/repository/dashboard_repository.dart';

class VerifyOtpController extends GetxController {
  final AuthRepository _repository = Get.find<AuthRepository>();
  
  RxString otp = "".obs;
  RxInt timer = 60.obs; 
  Timer? _timer;
  
  // Arguments
  late String verificationType; // 'email' or 'mobile'
  late String target;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    verificationType = args['type'] ?? 'email';
    target = args['target'] ?? '';
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    timer.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> resendCode() async {
    try {
      if (verificationType == 'email') {
        await _repository.sendEmailOtp();
      } else {
        await _repository.sendMobileOtp(target);
      }
      startTimer();
    } catch (e) {
      debugPrint("Error resending code: $e");
    }
  }

  Future<bool> verifyOtp() async {
    if (otp.value.length < 6) {
       return false;
    }
    
    try {
      dynamic response;
      if (verificationType == 'email') {
        response = await _repository.confirmEmailOtp(otp.value);
      } else {
        response = await _repository.confirmMobileOtp(otp.value);
      }

      if (response != null && response['status'] == true) {
        // Refresh user profile after verification
        await _refreshProfile();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error verifying OTP: $e");
      return false;
    }
  }

  Future<void> _refreshProfile() async {
    try {
      // Use DashboardRepository if available to fetch latest profile
      if (Get.isRegistered<DashboardRepository>()) {
         final dashRepo = Get.find<DashboardRepository>();
         final profileResponse = await dashRepo.getUserProfile();
         if (profileResponse != null && profileResponse['status'] == true) {
            final data = profileResponse;
            if (data['data']['user'] != null) {
               await SharedPrefs.setUser(data['data']['user']);
            }
         }
      }
    } catch (e) {
      debugPrint("Error refreshing profile: $e");
    }
  }
}
