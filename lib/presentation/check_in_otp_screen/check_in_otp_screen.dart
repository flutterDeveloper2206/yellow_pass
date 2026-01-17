import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';

import 'controller/check_in_otp_controller.dart';

class CheckInOtpScreen extends GetView<CheckInOtpController> {
  const CheckInOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final cafeName = controller.booking?.cafe?.name ?? "the Cafe";
    final isCheckOut = controller.isCheckOut;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: _buildAppBar(context, isDarkMode, isCheckOut),
              ),
              const SizedBox(height: 40),
              ZoomIn(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                  child: Icon(isCheckOut ? Icons.logout : Icons.vpn_key_outlined, size: 30, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  isCheckOut ? "Check-out Verification" : "Check-in Verification",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
                child: Text(
                  "Please enter the 6-digit ${isCheckOut ? 'check-out' : 'check-in'} OTP\nprovided at $cafeName",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                delay: const Duration(milliseconds: 200),
                child: _buildPinput(context, isDarkMode),
              ),
              const Spacer(),
              FadeInUp(
                duration: const Duration(milliseconds: 900),
                delay: const Duration(milliseconds: 400),
                child: Obx(() => SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.isProcessing.value 
                      ? null 
                      : () => controller.verifyOtp(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: controller.isProcessing.value
                      ? const CircularProgressIndicator(color: Colors.yellow)
                      : Text(
                          "Submit OTP",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isDarkMode ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                )),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDarkMode, bool isCheckOut) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios, 
            size: 20, 
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          isCheckOut ? "Check-out OTP" : "Check-in OTP",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPinput(BuildContext context, bool isDarkMode) {
    final defaultPinTheme = PinTheme(
      width: 65,
      height: 65,
      textStyle: TextStyle(
        fontSize: 24,
        color: isDarkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow, width: 2),
      ),
    );

    return Pinput(
      length: 6, // 4 digit OTP for check-in
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      showCursor: true,
      onChanged: (value) => controller.otp.value = value,
      onCompleted: (pin) => controller.otp.value = pin,
    );
  }
}
