import 'package:yellow_pass/core/utils/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
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
    return SafeArea(
      child: Obx(
            () => Scaffold(
          backgroundColor: flexSchemeLight.onPrimaryContainer,
          appBar: CommonAppBar(
            backgroundColor: ColorConstant.primaryBlack,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: getHeight(20),
                width: getWidth(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      height: getHeight(30),
                      width: getWidth(30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        size: getHeight(20),
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(width: getWidth(10)),
                    Container(
                      height: getHeight(30),
                      width: getWidth(30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        size: getHeight(20),
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            icon: Icons.location_on,
            iconColor: ColorConstant.primaryWhite,
            title: 'Navi Peth, Pune',
            textColor: ColorConstant.primaryWhite,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getHeight(10)),
                  CustomAppTextFormField(

                  ),
                  SizedBox(height: getHeight(10)),
                  SizedBox(
                    height: MediaQuery.of(Get.context!).size.height / 3, // fixed height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(Get.context!).size.width / 1.5,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: CustomImageView(
                                fit: BoxFit.fill,
                                imagePath: ImageConstant.imgSplashBg,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getHeight(10)),
                  Text('Explore Yellow Spaces', style: PMT.style(24,fontColor: Colors.white),),
                SizedBox(
                  height: MediaQuery.of(Get.context!).size.height /15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff303030),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade700),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.gamepad_outlined,color: Color(0xff797979)),
                                SizedBox(width: getWidth(10),),
                                const Text(
                                  'Poolside',
                                  style: TextStyle(color: Color(0xff797979)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                  SizedBox(height: getHeight(10)),
                  SizedBox(
                    height: MediaQuery.of(Get.context!).size.height / 4, // fixed height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(Get.context!).size.width /1.1,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: CustomImageView(
                                fit: BoxFit.fill,
                                imagePath: ImageConstant.imgSplashBg,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              
              
                ],
              ),
            ),
          ),
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
