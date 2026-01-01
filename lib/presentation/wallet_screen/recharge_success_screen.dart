import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';

class RechargeSuccessScreen extends StatelessWidget {
  final String amount;
  final String tokens;

  const RechargeSuccessScreen({
    super.key,
    required this.amount,
    required this.tokens,
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
              // Success Animation
              SizedBox(
                height: 200,
                width: 200,
                child: Lottie.network(
                  'https://lottie.host/56d0c404-566b-4786-9441-d69d49313276/7p15g2q1Y8.json',
                  repeat: false,
                  errorBuilder: (context, error, stackTrace) => _buildIconFallback(Icons.check_circle, Colors.green),
                ),
              ),
              
              const SizedBox(height: 32),
              
              Text(
                "Recharge Successful!",
                style: PMT.style(24, fontColor: textColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                "Your wallet has been recharged successfully",
                style: PMT.style(14, fontColor: Colors.grey),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Details Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF2C2C2C) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDarkMode ? [] : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount Paid",
                          style: PMT.style(14, fontColor: Colors.grey),
                        ),
                        Text(
                          "₹$amount",
                          style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tokens Added",
                          style: PMT.style(14, fontColor: Colors.grey),
                        ),
                        Text(
                          "$tokens Tokens",
                          style: PMT.style(18, fontColor: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close success screen
                    Get.back(); // Close recharge screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: Text(
                    "Done",
                    style: PMT.style(16, fontColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
