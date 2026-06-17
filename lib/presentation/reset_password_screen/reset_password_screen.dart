import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/image_constant.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/widgets/custom_app_text_form_field.dart';
import 'package:yellow_pass/widgets/custom_elavated_button.dart';
import 'controller/reset_password_controller.dart';

class ResetPasswordScreen extends GetWidget<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

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
            top: 100,
            child: Center(
              child: CustomImageView(
                imagePath: 'assets/images/logo_yellow.png',
                height: 74,
                width: 175,
              ),
            ),
          ),
          // Scrollable bottom sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black87 : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reset Password",
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
                        "Please check your email and enter the 6-digit OTP code along with your new password details below.",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // OTP Code Field
                      Text(
                        "6-Digit OTP Code",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter 6-digit OTP code",
                        controller: controller.otpController,
                        keyboardType: TextInputType.number,
                        fillColor: isDarkMode ? const Color(0xff2b2b2b) : Colors.grey.shade100,
                        borderColor: isDarkMode ? Colors.transparent : Colors.grey.shade300,
                        focusedBorderColor: ColorConstant.primaryColor,
                      ),
                      const SizedBox(height: 16),

                      // New Password Field
                      Text(
                        "New Password",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => CommonTextField(
                        hintText: "Enter new password",
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordHidden.value,
                        fillColor: isDarkMode ? const Color(0xff2b2b2b) : Colors.grey.shade100,
                        borderColor: isDarkMode ? Colors.transparent : Colors.grey.shade300,
                        focusedBorderColor: ColorConstant.primaryColor,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () => controller.isPasswordHidden.toggle(),
                        ),
                      )),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      Text(
                        "Confirm New Password",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => CommonTextField(
                        hintText: "Confirm new password",
                        controller: controller.confirmPasswordController,
                        obscureText: controller.isConfirmPasswordHidden.value,
                        fillColor: isDarkMode ? const Color(0xff2b2b2b) : Colors.grey.shade100,
                        borderColor: isDarkMode ? Colors.transparent : Colors.grey.shade300,
                        focusedBorderColor: ColorConstant.primaryColor,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () => controller.isConfirmPasswordHidden.toggle(),
                        ),
                      )),
                      const SizedBox(height: 25),

                      // Reset Password Action Button
                      AppElevatedButton2(
                        buttonName: "Reset Password",
                        buttonColor: ColorConstant.primaryColor,
                        textColor: Colors.black,
                        hasGradient: false,
                        onPressed: () {
                          controller.resetPassword();
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
