import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/image_constant.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/widgets/custom_app_text_form_field.dart';
import 'package:yellow_pass/widgets/custom_elavated_button.dart';
import 'controller/register_screen_controller.dart';

class RegisterScreen extends GetWidget<RegisterScreenController> {
  const RegisterScreen({super.key});

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
          // Logo (placed higher to avoid keyboard overlap)
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
          // Scrollable Sign Up Form container
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create Account",
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
                              color: isDarkMode
                                  ? Colors.grey
                                  : Colors.grey.shade600,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Join Yellow Pass to find the best creative workspaces near you.",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Name Field
                      Text(
                        "Full Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter your full name",
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        fillColor: isDarkMode
                            ? const Color(0xff2b2b2b)
                            : Colors.grey.shade100,
                        borderColor: isDarkMode
                            ? Colors.transparent
                            : Colors.grey.shade300,
                        focusedBorderColor: ColorConstant.primaryColor,
                      ),
                      const SizedBox(height: 16),

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
                        fillColor: isDarkMode
                            ? const Color(0xff2b2b2b)
                            : Colors.grey.shade100,
                        borderColor: isDarkMode
                            ? Colors.transparent
                            : Colors.grey.shade300,
                        focusedBorderColor: ColorConstant.primaryColor,
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => CommonTextField(
                            hintText: "Enter your password",
                            controller: controller.passwordController,
                            obscureText: controller.isPasswordHidden.value,
                            fillColor: isDarkMode
                                ? const Color(0xff2b2b2b)
                                : Colors.grey.shade100,
                            borderColor: isDarkMode
                                ? Colors.transparent
                                : Colors.grey.shade300,
                            focusedBorderColor: ColorConstant.primaryColor,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () =>
                                  controller.isPasswordHidden.toggle(),
                            ),
                          )),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => CommonTextField(
                            hintText: "Confirm your password",
                            controller: controller.confirmPasswordController,
                            obscureText:
                                controller.isConfirmPasswordHidden.value,
                            fillColor: isDarkMode
                                ? const Color(0xff2b2b2b)
                                : Colors.grey.shade100,
                            borderColor: isDarkMode
                                ? Colors.transparent
                                : Colors.grey.shade300,
                            focusedBorderColor: ColorConstant.primaryColor,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isConfirmPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () =>
                                  controller.isConfirmPasswordHidden.toggle(),
                            ),
                          )),
                      const SizedBox(height: 16),

                      // Referral Code Field (Optional)
                      Text(
                        "Referral Code (Optional)",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonTextField(
                        hintText: "Enter referral code",
                        controller: controller.referralCodeController,
                        fillColor: isDarkMode
                            ? const Color(0xff2b2b2b)
                            : Colors.grey.shade100,
                        borderColor: isDarkMode
                            ? Colors.transparent
                            : Colors.grey.shade300,
                        focusedBorderColor: ColorConstant.primaryColor,
                      ),
                      const SizedBox(height: 25),

                      // Register Button
                      AppElevatedButton2(
                        buttonName: "Register",
                        buttonColor: ColorConstant.primaryColor,
                        textColor: Colors.black,
                        hasGradient: false,
                        onPressed: () {
                          controller.registerUser();
                        },
                      ),
                      const SizedBox(height: 20),

                      // Already have an account? Log In
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.back(),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: ColorConstant.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Terms & Privacy
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "By Continuing you agree to Yellowspace's",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () => _showTermsAndPrivacyBottomSheet(context),
                              child: Text(
                                "Terms and Conditions & Privacy Policy",
                                style: TextStyle(
                                  color: ColorConstant.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
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

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not launch URL");
    }
  }

  void _showTermsAndPrivacyBottomSheet(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Document",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: Icon(Icons.description_outlined, color: ColorConstant.primaryColor),
              title: Text(
                "Terms and Conditions",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onTap: () {
                Get.back();
                _launchURL("https://yellowpass.in/terms-and-conditions");
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined, color: ColorConstant.primaryColor),
              title: Text(
                "Privacy Policy",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onTap: () {
                Get.back();
                _launchURL("https://yellowpass.in/privacy-policy");
              },
            ),
          ],
        ),
      ),
    );
  }
}
