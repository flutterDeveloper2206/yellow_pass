import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/widgets/bouncing_button.dart';
import 'package:yellow_pass/widgets/custom_app_text_form_field.dart';
import '../../core/theme/light_theme.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';
import 'controller/dashboard_screen_controller.dart';

class DashboardScreen extends GetWidget<DashboardScreenController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: flexSchemeLight.secondary,
            body: controller.pages[controller.currentIndex.value],
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
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
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
      ),
    );
  }
}
