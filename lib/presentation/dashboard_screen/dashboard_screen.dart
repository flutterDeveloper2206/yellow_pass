import 'package:yellow_pass/core/utils/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'controller/dashboard_screen_controller.dart';

class DashboardScreen extends GetWidget<DashboardScreenController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
            () => Scaffold(
          backgroundColor: ColorConstant.primaryBlack,

          // ✅ Common AppBar
          appBar: CommonAppBar(),

          // ✅ Empty Body
          body: const Center(
            child: Text(
              "Dashboard Content Removed",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),

          // ✅ Floating Action Button
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstant.primaryBlack,
            onPressed: () => Get.snackbar("FAB", "QR Code Pressed"),
            shape: const CircleBorder(
              side: BorderSide(
                color: ColorConstant.textGreyColor,
                width: 1,
              ),
            ),
            child: const Icon(Icons.qr_code, color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          // ✅ Bottom Navigation Bar
          bottomNavigationBar: AnimatedBottomNavigationBar(
            borderColor: ColorConstant.bottomSheetDragColor,
            borderWidth: 2,
            icons: controller.iconList,
            shadow: const BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 0.5,
              color: ColorConstant.icGrayColor,
            ),
            backgroundColor: ColorConstant.primaryBlack,
            activeIndex: controller.currentIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            activeColor: ColorConstant.primaryOrange,
            inactiveColor: ColorConstant.primaryWhite,
            splashRadius: 0,
            onTap: (index) => controller.currentIndex.value = index,
          ),
        ),
      ),
    );
  }
}
