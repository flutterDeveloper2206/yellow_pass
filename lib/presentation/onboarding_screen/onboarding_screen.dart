import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'controller/onboarding_screen_controller.dart';

class OnboardingScreen extends GetWidget<OnboardingScreenController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => Stack(
          children: [
            /// Fullscreen background image
            Positioned.fill(
              child: Image.asset(
                controller.pages[controller.currentPage.value]["image"]!,
                fit: BoxFit.cover,
              ),
            ),

            /// Dark overlay for readability
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.45),
              ),
            ),

            /// Skip Button
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.goToLogin();
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Page Content
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
                      /// Title
                      RichText(
                        text: TextSpan(
                          text: "Cafe + ",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: [
                            const TextSpan(
                              text: "CoWorking ",
                              style: TextStyle(color: Colors.yellow),
                            ),
                            const TextSpan(
                              text: "Spaces for creative ",
                              style: TextStyle(color: Colors.white),
                            ),
                            const TextSpan(
                              text: "Idealist .",
                              style: TextStyle(color: Colors.yellow),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getHeight(150),),
                    ],
                  ),
                );
              },
            ),

            /// Bottom Section
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.pages.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(4),
                        height: 10,
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

                  /// Next / Get Started Button
                  SizedBox(
                    width: getWidth(200),
                    height: getHeight(55),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      onPressed: (){
                        controller.nextPage();
                      },
                      child: Obx(
                        () => Text(
                  controller.currentPage.value == controller.pages.length - 1
                  ? "Login"
                      : "Next",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),

    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
