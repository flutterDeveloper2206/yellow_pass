import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'package:yellow_pass/widgets/custom_elavated_button.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import '../../core/theme/light_theme.dart';
import 'controller/onboarding_screen_controller.dart';

class OnboardingScreen extends GetWidget<OnboardingScreenController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
              () => Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: CustomImageView(
                  width: double.infinity,
                  imagePath: controller.pages[controller.currentPage.value]["image"]!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                    onTap: () {
                        controller.goToLogin();
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 18,
                          color: flexSchemeLight.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Cafe + ",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "CoWorking ",
                                style: TextStyle(color: Colors.yellow),
                              ),
                              TextSpan(
                                text: "Spaces for creative ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: "Idealist .",
                                style: TextStyle(color: Colors.yellow),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: getHeight(150)),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        controller.pages.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(4),
                          height: getHeight(10),
                          width: index == controller.currentPage.value ? 25 : 10,
                          decoration: BoxDecoration(
                            color: index == controller.currentPage.value
                                ? Colors.yellow
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: getHeight(30)),

                    SizedBox(
                      width: MediaQuery.of(Get.context!).size.width / 2.5,
                      height: getHeight(55),
                      child: Obx(
                            () => AppElevatedButton(
                              radius: 50,
                              buttonColor: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            controller.nextPage();
                          },
                          buttonName: controller.currentPage.value == controller.pages.length - 1
                              ? "Login"
                              : "Next",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
