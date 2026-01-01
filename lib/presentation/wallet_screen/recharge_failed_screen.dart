import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';

class RechargeFailedScreen extends StatelessWidget {
  final String? errorMessage;

  const RechargeFailedScreen({
    super.key,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 80,
                  color: Colors.red,
                ),
              ),
              
              const SizedBox(height: 32),
              
              Text(
                "Payment Failed",
                style: PMT.style(24, fontColor: textColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                errorMessage ?? "Your payment could not be processed. Please try again.",
                style: PMT.style(14, fontColor: Colors.grey),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Retry Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Go back to recharge screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    foregroundColor: isDarkMode ? Colors.black : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: Text(
                    "Try Again",
                    style: PMT.style(
                      16, 
                      fontColor: isDarkMode ? Colors.black : Colors.white, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Cancel Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back(); // Close failed screen
                    Get.back(); // Close recharge screen
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    "Cancel",
                    style: PMT.style(16, fontColor: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
