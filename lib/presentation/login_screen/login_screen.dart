import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/widgets/custom_elavated_button.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import '../../core/utils/common_app_bar.dart';
import '../../widgets/custom_app_text_form_field.dart';
import 'controller/login_screen_controller.dart';

class LoginScreen extends GetWidget<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryWhite,
      appBar: CommonAppBar(title: 'Login'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back 👋",
                  style: PMT.style(
                    30,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login to continue",
                  style: PMT.style(16, fontColor: Colors.grey.shade600),
                ),
                const SizedBox(height: 40),

                // Email field
                CustomAppTextFormField(
                  hintText: "Email",
                  prefix: Icon(Icons.call),
                  controller: controller.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password field
                CustomAppTextFormField(
                  hintText: "Password",
                  prefix: Icon(Icons.lock_outline),
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: PMT.style(14, fontColor: ColorConstant.primaryOrange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: AppElevatedButton(
                    buttonName: 'Login',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        Get.toNamed(AppRoutes.dashboardScreenRoute);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),

                Center(
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.registerScreenRoute),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: PMT.style(14, fontColor: Colors.grey.shade600),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: PMT.style(
                              14,
                              fontColor: ColorConstant.primaryOrange,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}
