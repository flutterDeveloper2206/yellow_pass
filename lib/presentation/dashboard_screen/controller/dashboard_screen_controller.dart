import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yellow_pass/presentation/home_screen/home_screen.dart';
import 'package:yellow_pass/presentation/profile_screen/profile_screen.dart';
import 'package:yellow_pass/presentation/wallet_screen/wallet_screen.dart';
import 'package:yellow_pass/presentation/nearby_screen/nearby_screen.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/my_bookings_screen.dart';
import '../repository/dashboard_repository.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../profile_screen/controller/profile_screen_controller.dart';
import '../../profile_details_screen/controller/profile_details_controller.dart';
import '../../home_screen/controller/home_screen_controller.dart';
import '../../../../widgets/common_snackbar.dart';
import '../../../../core/utils/commonConstant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';

class DashboardScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.location_on_outlined, // Nearby
    Icons.account_balance_wallet_outlined,
    Icons.person_2_outlined,
  ];

  // Example pages
  final List<Widget> pages = [
    HomeScreen(),
    const NearbyScreen(),
    const WalletScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    _fetchUserProfile();
    _updateUserLocation();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final repository = Get.find<DashboardRepository>();
      final dynamic response = await repository.getUserProfile();

      if (response != null) {
        final data = response; // ApiService returns response.body directly

        if (data is Map && data['status'] == true) {
          final userData = data['data']['user'];
          if (userData != null) {
            await SharedPrefs.setUser(userData);

            // Refresh data in other controllers if they exist
            if (Get.isRegistered<ProfileScreenController>()) {
              Get.find<ProfileScreenController>().loadUserData();
            }
            if (Get.isRegistered<ProfileDetailsController>()) {
              Get.find<ProfileDetailsController>().loadUserData();
            }
            if (Get.isRegistered<HomeScreenController>()) {
              Get.find<HomeScreenController>().loadUserData();
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      // Silent failure or show snackbar if critical
    }
  }

  Future<void> _updateUserLocation() async {
    try {
      Position? position = await CommonConstant.instance.getCurrentLocation();
      if (position != null) {
        final repository = Get.put(DashboardRepository());
        await repository.updateLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      }
    } catch (e) {
      debugPrint("Error updating location: $e");
    }
  }

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
    final BuildContext? ctx = Get.context ?? Get.overlayContext;
    final bool isDark = ctx != null
        ? Theme.of(ctx).brightness == Brightness.dark
        : Get.isDarkMode;

    // Explicit dialog palette — app ColorScheme maps black surfaces to dark on* text,
    // which is unreadable; keep contrast here without editing theme color files.
    final Color dialogBg = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final Color titleColor =
        isDark ? const Color(0xFFE8E8E8) : const Color(0xFF090909);
    final Color bodyColor =
        isDark ? const Color(0xFFB0B3B8) : const Color(0xFF5F6368);
    final Color borderColor =
        isDark ? const Color(0xFF6B6B6B) : const Color(0xFFE0E0E0);

    final TextTheme textTheme = Get.theme.textTheme;

    return await Get.dialog<bool>(
          Dialog(
            backgroundColor: dialogBg,
            surfaceTintColor: Colors.transparent,
            elevation: isDark ? 8 : 2,
            shadowColor: isDark ? Colors.black54 : Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: borderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor
                          .withValues(alpha: isDark ? 0.22 : 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 36,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Exit App",
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Are you sure you want to exit?",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: bodyColor,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(result: false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: titleColor,
                            side: BorderSide(color: borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            "No",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: titleColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Get.back(result: true);
                            SystemNavigator.pop();
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
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
          barrierDismissible: true,
          barrierColor: Colors.black.withValues(alpha: isDark ? 0.65 : 0.45),
        ) ??
        false;
  }
}
