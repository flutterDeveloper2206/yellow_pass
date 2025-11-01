import 'dart:ui';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'package:yellow_pass/widgets/custom_elavated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'controller/onboarding_screen_controller.dart';

class OnboardingScreen extends GetWidget<OnboardingScreenController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: themeColor.secondary,
      body: Obx(
            () => Stack(
          children: [
            // Animated gradient background
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              // decoration: const BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [Color(0xFFa1c4fd), Color(0xFFc2e9fb)]
              //     ,
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //   ),
              // ),
            ),

            // Main onboarding content
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.onboardingPages.length,
              itemBuilder: (context, index) {
                final page = controller.onboardingPages[index];
                final isCurrent = controller.currentPage.value == index;
                return _OnboardingContent(
                  title: page['title']!,
                  subtitle: page['subtitle']!,
                  image: page['image']!,
                  isCurrent: isCurrent,
                );
              },
            ),

            // Bottom buttons + indicators
            Positioned(
              bottom: getHeight(50),
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _GlowingIndicators(
                    length: controller.onboardingPages.length,
                    currentIndex: controller.currentPage.value,
                  ),
                  SizedBox(height: getHeight(40)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: AppElevatedButton(
                      onPressed: controller.isLastPage
                          ? controller.goToLogin
                          : controller.nextPage,
                      buttonName:
                      controller.isLastPage ? "Get Started" : "Next",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Unique content card per onboarding page
class _OnboardingContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final bool isCurrent;

  const _OnboardingContent({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: isCurrent ? 1 : 0.0,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 600),
        scale: isCurrent ? 1.0 : 0.95,
        curve: Curves.easeOut,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, isCurrent ? 0 : 30),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  height: isCurrent ? getHeight(250) : getHeight(200),
                  child: Hero(
                    tag: image,
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: PMT.style(
                            26,
                            fontWeight: FontWeight.w700,
                            fontColor: ColorConstant.primaryBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          subtitle,
                          style: PMT.style(
                            16,
                            fontColor: ColorConstant.primaryBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Glowing page indicator with animation
class _GlowingIndicators extends StatelessWidget {
  final int length;
  final int currentIndex;

  const _GlowingIndicators({
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: isActive ? 12 : 8,
          width: isActive ? 12 : 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white38,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ]
                : [],
          ),
        );
      }),
    );
  }
}
