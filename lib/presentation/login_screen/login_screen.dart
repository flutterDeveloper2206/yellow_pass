import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/widgets/custom_app_text_form_field.dart';
import 'package:yellow_pass/widgets/custom_elavated_button.dart';
import '../../core/utils/image_constant.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'controller/login_screen_controller.dart';

class LoginScreen extends GetWidget<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            top: 200,
            child: Center(
              child: CustomImageView(
                imagePath: 'assets/images/logo_yellow.png',
                height: 74,
                width: 175,
              ),
            ),
          ),
          // Bottom Sheet UI
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              final isDarkMode =
                  Theme.of(context).brightness == Brightness.dark;
              return AnimatedContainer(
                height: MediaQuery.of(context).size.height / 1.5,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black87 : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!controller.isReferralView.value)
                        _buildGetStartedView(context)
                      else
                        _buildReferralView(context),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedView(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {}, // Close action if needed
                icon: Icon(
                  Icons.close,
                  color: isDarkMode ? Colors.grey : Colors.grey.shade600,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Register to find your perfect creative workspace from 400+ spaces, 12+ cities & connect with fellow subscribers.",
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Email & Password Fields
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
            fillColor:
                isDarkMode ? const Color(0xff2b2b2b) : Colors.grey.shade100,
            borderColor: isDarkMode ? Colors.transparent : Colors.grey.shade300,
            focusedBorderColor: ColorConstant.primaryColor,
          ),
          const SizedBox(height: 16),
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
                fillColor:
                    isDarkMode ? const Color(0xff2b2b2b) : Colors.grey.shade100,
                borderColor:
                    isDarkMode ? Colors.transparent : Colors.grey.shade300,
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
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.forgotPasswordScreenRoute);
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Login Button
          AppElevatedButton2(
            buttonName: "Log In",
            buttonColor: ColorConstant.primaryColor,
            textColor: Colors.black,
            hasGradient: false,
            onPressed: () {
              controller.loginWithEmail();
            },
          ),
          const SizedBox(height: 20),

          // Divider
          Row(
            children: [
              Expanded(
                child: Divider(
                  color:
                      isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "or",
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade500
                        : Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color:
                      isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // LinkedIn Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                controller.goToLogin();
              },
              child: Text(
                "Continue with Linkedin",
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Referral Code Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                controller.toggleReferralView();
              },
              child: Text(
                "Enter Referral Code",
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Don't have an account? Sign Up
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.registerScreenRoute);
                },
                child: Text(
                  "Sign Up",
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
    );
  }

  Widget _buildReferralView(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Referral Code",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.toggleReferralView();
                },
                icon: Icon(
                  Icons.close,
                  color: isDarkMode ? Colors.grey : Colors.grey.shade600,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Please enter the referral code here to proceed and avail your discount.",
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),

          // Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
            ),
            child: TextField(
              controller: controller.referralCodeController,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Enter Code here",
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.grey.shade500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "eg: AGD123",
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 25),

          // Proceed Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                controller.proceedWithReferral();
              },
              child: Text(
                "Continue with Linkedin",
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
              leading: Icon(Icons.description_outlined,
                  color: ColorConstant.primaryColor),
              title: Text(
                "Terms and Conditions",
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onTap: () {
                Get.back();
                _launchURL("https://yellowpass.in/terms-and-conditions");
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined,
                  color: ColorConstant.primaryColor),
              title: Text(
                "Privacy Policy",
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
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
