import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yellow_pass/presentation/home_screen/home_screen.dart';
import 'package:yellow_pass/presentation/profile_screen/profile_screen.dart';
import 'package:yellow_pass/presentation/wallet_screen/wallet_screen.dart';
import 'package:yellow_pass/presentation/nearby_screen/nearby_screen.dart';

import 'package:yellow_pass/presentation/my_bookings_screen/my_bookings_screen.dart';

class DashboardScreenController extends GetxController {

  final RxInt currentIndex = 0.obs;
  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.receipt_long_outlined, // My Bookings
    Icons.account_balance_wallet_outlined,
    Icons.person_2_outlined,
  ];

  // Example pages
  final List<Widget> pages = [
    HomeScreen(),
    const MyBookingsScreen(),
    const WalletScreen(),
    ProfileScreen(),
  ];

  // Handle back button press
  Future<bool> onWillPop() async {
    if (currentIndex.value != 0) {
      // If not on home screen, navigate to home
      currentIndex.value = 0;
      return false; // Don't exit app
    } else {
      // If on home screen, show exit dialog
      return await _showExitDialog();
    }
  }

  Future<bool> _showExitDialog() async {
    return await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.exit_to_app,
                size: 60,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              const Text(
                "Exit App",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Are you sure you want to exit?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(result: false),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "No",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(result: true);
                        SystemNavigator.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ) ?? false;
  }
}
