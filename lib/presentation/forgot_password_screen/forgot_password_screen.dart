import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/image_constant.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/widgets/custom_app_text_form_field.dart';
import 'package:yellow_pass/widgets/custom_elavated_button.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends GetWidget<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          // Background Image
          Positioned.fill(
            child: CustomImageView(
              imagePath: ImageConstant.imgLoginBg,
              fit: BoxFit.cover,
            ),
          ),
          // Logo
          Positioned(
            top: 150,
            child: Center(
              child: CustomImageView(
                imagePath: 'assets/images/logo_yellow.png',
                height: 74,
                width: 175,
              ),
            ),
          ),
          // Bottom Sheet Form Container
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black87 : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.close,
                            color: isDarkMode ? Colors.grey : Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Please enter your registered email address below. We will send you a 6-digit OTP code to verify your identity and reset your password.",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Email Field
                    Text(
                      "Email Address",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CommonTextField(
                      hintText: "Enter your email",
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      fillColor: isDarkMode ? const Color(0xff2b2b2b) : Colors.grey.shade100,
                      borderColor: isDarkMode ? Colors.transparent : Colors.grey.shade300,
                      focusedBorderColor: ColorConstant.primaryColor,
                    ),
                    const SizedBox(height: 25),

                    // Action Button
                    AppElevatedButton2(
                      buttonName: "Send OTP",
                      buttonColor: ColorConstant.primaryColor,
                      textColor: Colors.black,
                      hasGradient: false,
                      onPressed: () {
                        controller.sendOtp();
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
