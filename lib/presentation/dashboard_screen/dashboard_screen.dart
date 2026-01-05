import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animate_do/animate_do.dart';
import 'controller/dashboard_screen_controller.dart';

class DashboardScreen extends GetWidget<DashboardScreenController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await controller.onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
        child: Obx(
          () => Scaffold(
            backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
            extendBody: true, // Allows content to flow behind the bar for a premium feel
            body: Stack(
              alignment: AlignmentGeometry.bottomCenter,
              children: [
                controller.pages[controller.currentIndex.value],
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left:15, right:15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: AnimatedBottomNavigationBar(
                      borderColor: isDark ? const Color(0xFF2C2C2C) : Colors.transparent,
                      borderWidth: 1,
                      icons: controller.iconList,
                      shadow: BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 20,
                        spreadRadius: 5,
                        color: isDark ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                      ),
                      backgroundColor: Colors.black,
                      activeIndex: controller.currentIndex.value,
                      gapLocation: GapLocation.none,
                      notchSmoothness: NotchSmoothness.softEdge,
                      activeColor: Colors.yellow,
                      inactiveColor: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                      splashRadius: 0,
                      iconSize: 28,
                      height: 60,
                      onTap: (index) => controller.currentIndex.value = index,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
