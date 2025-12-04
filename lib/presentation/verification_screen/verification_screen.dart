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
              _buildVerificationItem(
                context, 
                icon: Icons.email_outlined, 
                title: "Verify Email ID", 
                onTap: () {
                  Get.toNamed(AppRoutes.verifyOtpScreenRoute, arguments: {'type': 'email', 'target': 'vaishushrivat@gmail.com'});
                }, 
                isDark: isDark, 
                textColor: textColor, 
                cardColor: cardColor
              ),
              _buildVerificationItem(
                context, 
                icon: Icons.phone_outlined, 
                title: "Verify Mobile Number", 
                onTap: () {
                  Get.toNamed(AppRoutes.verifyOtpScreenRoute, arguments: {'type': 'mobile', 'target': '+91 8605927522'});
                }, 
                isDark: isDark, 
                textColor: textColor, 
                cardColor: cardColor
              ),
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
              "Profile",
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
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFD54F), 
                  width: 2, 
                  style: BorderStyle.solid 
                ),
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop',
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD54F),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Icon(Icons.edit, size: 14, color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Vaishnavi Shrivat",
          style: PMT.style(20, fontColor: textColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          "UI/UX Designer",
          style: PMT.style(14, fontColor: subTextColor),
        ),
        const SizedBox(height: 12),
        Text(
          "UI/UX Designer | Business Understanding | Exploring\nFrontend Development | Integrating AI for Seamless,\nData-Driven Experiences",
          textAlign: TextAlign.center,
          style: PMT.style(11, fontColor: subTextColor, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildVerificationItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap, required bool isDark, required Color textColor, required Color cardColor}) {
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
        onTap: onTap,
        leading: Icon(icon, color: isDark ? Colors.white : Colors.black54),
        title: Text(
          title,
          style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.info_outline, size: 20, color: Color(0xFFFFD54F)), // Yellow info icon
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
