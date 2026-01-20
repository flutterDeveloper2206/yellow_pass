import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'controller/check_in_success_controller.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';

class CheckInSuccessScreen extends GetView<CheckInSuccessController> {
  const CheckInSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Dynamic Animation (Success or Error)
                  _buildAnimation(controller.isSuccess.value, isDark),

                  const SizedBox(height: 40),
                  Text(
                    controller.title.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: controller.isSuccess.value
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.isSuccess.value
                        ? "You have successfully ${controller.title.value.contains("Check-out") ? "checked out from" : "checked in at"} ${controller.cafeName.value}."
                        : (controller.message.value.isNotEmpty
                            ? controller.message.value
                            : "Something went wrong during check-in. Please try again or contact support."),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Only show WiFi section on success
                  if (controller.isSuccess.value) _buildWifiContainer(isDark),

                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.onContinue(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isSuccess.value
                            ? ColorConstant.primaryColor
                            : Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        controller.isSuccess.value ? "Continue" : "Try Again",
                        style: TextStyle(
                          color: controller.isSuccess.value
                              ? Colors.black
                              : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildAnimation(bool isSuccess, bool isDark) {
    if (isSuccess) {
      return SizedBox(
        height: 200,
        width: 200,
        child: Lottie.network(
          'https://lottie.host/56d0c404-566b-4786-9441-d69d49313276/7p15g2q1Y8.json',
          repeat: false,
          errorBuilder: (context, error, stackTrace) =>
              _buildIconFallback(Icons.check_circle, Colors.green),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 100,
        ),
      );
    }
  }

  Widget _buildIconFallback(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 100),
    );
  }

  Widget _buildWifiContainer(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Auto-connecting WiFi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Connected to 'Cafe_Guest'",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_outline, color: Colors.green),
        ],
      ),
    );
  }
}
