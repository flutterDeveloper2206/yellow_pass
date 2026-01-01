import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/verification_screen/controller/verification_controller.dart';
import 'package:yellow_pass/routes/app_routes.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              _buildAppBar(context, textColor, isDark),
              const SizedBox(height: 30),
              _buildProfileHeader(context, textColor, subTextColor, isDark),
              const SizedBox(height: 40),
              Obx(() => _buildVerificationItem(
                context, 
                icon: Icons.email_outlined, 
                title: "Verify Email ID", 
                status: (controller.userData['is_email_verified'] == true || controller.userData['is_email_verified'] == 1),
                onTap: controller.sendEmailVerification, 
                isDark: isDark, 
                textColor: textColor, 
                cardColor: cardColor
              )),
              Obx(() => _buildVerificationItem(
                context, 
                icon: Icons.phone_outlined, 
                title: "Verify Mobile Number", 
                status: (controller.userData['is_mobile_verified'] == true || controller.userData['is_mobile_verified'] == 1),
                onTap: controller.sendMobileVerification, 
                isDark: isDark, 
                textColor: textColor, 
                cardColor: cardColor
              )),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.dashboardScreenRoute); // Or home route
                },
                child: Text(
                  "Go to Home page",
                  style: PMT.style(14, fontColor: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Color textColor, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, size: 20, color: textColor),
            ),
            const SizedBox(width: 8),
            Text(
              "Verification",
              style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200,
          ),
          child: Icon(Icons.delete_outline, size: 20, color: isDark ? Colors.grey : Colors.black54),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, Color textColor, Color subTextColor, bool isDark) {
    return Column(
      children: [
        Obx(() => Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color:  Colors.yellow,
              width: 2, 
              style: BorderStyle.solid 
            ),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: (controller.userData['profile_picture'] != null && controller.userData['profile_picture'].toString().isNotEmpty)
                ? NetworkImage("${controller.userData['profile_picture']}") as ImageProvider
                : const AssetImage('assets/images/profiles.png'),
          ),
        )),
        const SizedBox(height: 16),
        Obx(() => Text(
          controller.userData['name'] ?? "User Name",
          style: PMT.style(20, fontColor: textColor, fontWeight: FontWeight.bold),
        )),
        const SizedBox(height: 4),
        Obx(() => Text(
          controller.userData['email'] ?? "Email ID",
          style: PMT.style(14, fontColor: subTextColor),
        )),
        const SizedBox(height: 12),
        Obx(() => Text(
          controller.userData['description'] ?? "No Bio Added",
          textAlign: TextAlign.center,
          style: PMT.style(11, fontColor: subTextColor, fontWeight: FontWeight.w400),
        )),
      ],
    );
  }

  Widget _buildVerificationItem(BuildContext context, {required IconData icon, required String title, required bool status, required VoidCallback onTap, required bool isDark, required Color textColor, required Color cardColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: status ? null : onTap,
        leading: Icon(icon, color: isDark ? Colors.white : Colors.black54),
        title: Text(
          title,
          style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          status ? Icons.check_circle_outline : Icons.info_outline, 
          size: 20, 
          color: status ? Colors.green : Colors.yellow
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
