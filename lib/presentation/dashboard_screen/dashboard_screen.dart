import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
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
    return SafeArea(
      child: Obx(
            () => Scaffold(
          backgroundColor: flexSchemeLight.secondary,
          body: Stack(
            children: [
              CustomImageView(
                fit: BoxFit.fill,
                imagePath: ImageConstant.imgDbBg,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: getHeight(30),
                            width: getWidth(30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              SizedBox(
                                width: getWidth(10),
                              ),
                              Text(
                                'Navi Peth, Pune',
                                style: PMT.style(12,
                                    fontColor: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Container(
                                  height: getHeight(25),
                                  width: getWidth(25),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: getHeight(15),
                                    color: Colors.yellow,
                                  ),
                                ),
                                SizedBox(width: getWidth(10)),
                                Container(
                                  height: getHeight(25),
                                  width: getWidth(25),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.notifications_active_outlined,
                                    size: getHeight(15),
                                    color: Colors.yellow,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(10)),
                      CommonTextField(
                          borderRadius: 50,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomImageView(
                              svgPath: ImageConstant.icSetting,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          prefixIcon: Icons.search,
                          hintText: 'Search cafe, co-workers ',
                          fillColor: flexSchemeLight.secondaryFixedDim
                              .withOpacity(.4)),
                      SizedBox(height: getHeight(30)),
                      SizedBox(
                        height: MediaQuery.of(Get.context!).size.height / 3.1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Bounce(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(Get.context!)
                                      .size
                                      .width /
                                      1.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                    Border.all(color: Colors.grey.shade700),
                                  ),
                                  child: Stack(
                                    children: [
                                      CustomImageView(
                                        fit: BoxFit.contain,
                                        imagePath: ImageConstant.imgDbListBg,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Featured',
                                                  style: PMT.style(12,
                                                      fontColor: Colors.yellow),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                    border: Border.all(
                                                        color:
                                                        Colors.grey.shade700),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Text(
                                                      '10% off',
                                                      style: PMT.style(12,
                                                          fontColor: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w900),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                color: Colors.black45,
                                              ),
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Cafe Aarosh',
                                                      style: PMT.style(14,
                                                          fontColor: Colors.white,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                        SizedBox(
                                                            width:
                                                            getWidth(5)),
                                                        Text(
                                                          'Sadashiv Peth, Pune',
                                                          style: PMT.style(12,
                                                              fontColor:
                                                              Colors.white,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Cafe Aarosh is a premium partner veirfied cafe by yellowspace..',
                                                      style: PMT.style(12,
                                                          fontColor: Colors.grey,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),

                                                    /// ✅ FIX APPLIED HERE
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                size: 20,
                                                                color:
                                                                Colors.yellow,
                                                              ),
                                                              Text(
                                                                '5/5',
                                                                style: PMT.style(
                                                                    14,
                                                                    fontColor:
                                                                    Colors
                                                                        .yellow,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                20),
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons.wifi,
                                                                  size: 15,
                                                                  color:
                                                                  Colors.white,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                    getWidth(
                                                                        5)),
                                                                const Icon(
                                                                  Icons
                                                                      .electric_bolt,
                                                                  size: 15,
                                                                  color:
                                                                  Colors.white,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
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
                      Text(
                        'Explore Yellow Spaces',
                        style: PMT.style(18, fontColor: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(Get.context!).size.height / 15,
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
                                  border:
                                  Border.all(color: Colors.grey.shade700),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.gamepad_outlined,
                                          color: Color(0xff797979)),
                                      SizedBox(
                                        width: getWidth(10),
                                      ),
                                      const Text(
                                        'Poolside',
                                        style:
                                        TextStyle(color: Color(0xff797979)),
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

                      /// ✅ SECOND PART WHERE FIX IS APPLIED
                      SizedBox(
                        height: MediaQuery.of(Get.context!).size.height / 4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(Get.context!)
                                              .size
                                              .width /
                                              1.16,
                                          decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                color: ColorConstant.bgGrey,
                                              )
                                            ],
                                            border: Border.all(
                                                color: Colors.grey.shade700),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            child: CustomImageView(
                                              fit: BoxFit.fill,
                                              imagePath:
                                              ImageConstant.imgSplashBg,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1.2, // ✅ FIX APPLIED
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: getHeight(10)),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Cafe Aarosh',
                                                    style: PMT.style(14,
                                                        fontColor:
                                                        Colors.black87,
                                                        fontWeight:
                                                        FontWeight.w900),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          size: 20,
                                                          color:
                                                          Colors.yellow),
                                                      Text(
                                                        '5/5',
                                                        style: PMT.style(14,
                                                            fontColor:
                                                            Colors.yellow,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.black87,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                      width: getWidth(5)),
                                                  Text(
                                                    'Sadashiv Peth, Pune',
                                                    style: PMT.style(12,
                                                        fontColor:
                                                        Colors.grey,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Cafe Aarosh is a premium partner veirfied cafe by yellowspace..',
                                                style: PMT.style(12,
                                                    fontColor: Colors.grey,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
            ],
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
    );
  }
}
