import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/profile_screen/controller/profile_screen_controller.dart';
import 'package:yellow_pass/routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late ProfileScreenController controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileScreenController());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Define specific colors based on the screenshot analysis
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final accentColor = const Color(0xFFFFD54F); // Yellow

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  _buildAppBar(context, textColor, isDark),
                  const SizedBox(height: 30),
                  _buildProfileHeader(context, textColor, subTextColor, accentColor),
                  const SizedBox(height: 30),
                  _buildStatsRow(context, isDark, textColor, subTextColor, cardColor),
                  const SizedBox(height: 30),
                  _buildVisibilityToggle(context, isDark, textColor, cardColor, accentColor),
                  const SizedBox(height: 20),
                  _buildMenuItem(context, icon: Icons.calendar_today_outlined, title: "My Bookings", onTap: () {
                    Get.toNamed(AppRoutes.myBookingsScreenRoute);
                  }, isDark: isDark, textColor: textColor, cardColor: cardColor),
                  _buildMenuItem(context, icon: Icons.wallet_membership_outlined, title: "Subscription", onTap: () {}, isDark: isDark, textColor: textColor, cardColor: cardColor),
                  _buildMenuItem(context, icon: Icons.person_outline, title: "My Details", onTap: () {
                    Get.toNamed(AppRoutes.profileDetailsScreenRoute);
                  }, isDark: isDark, textColor: textColor, cardColor: cardColor),
                  _buildMenuItem(context, icon: Icons.settings_outlined, title: "Settings", onTap: () {
                    Get.toNamed(AppRoutes.settingsScreenRoute);
                  }, isDark: isDark, textColor: textColor, cardColor: cardColor),
                  const SizedBox(height: 30),
                  _buildLogoutButton(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
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
            Icon(Icons.arrow_back_ios, size: 20, color: textColor),
            const SizedBox(width: 8),
            Text(
              "Profile",
              style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            if (isDark) ...[
               Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.yellow, width: 1),
                  color: Colors.transparent,
                ),
                child: const Icon(Icons.visibility, size: 18, color: Colors.yellow),
              ),
              const SizedBox(width: 10),
            ],

          ],
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, Color textColor, Color subTextColor, Color accentColor) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: accentColor, 
                  width: 2, 
                  style: BorderStyle.solid // Dashed border is complex in Flutter without external package, solid for now or CustomPainter
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
                  color: accentColor,
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
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, size: 16, color: Colors.green),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.verificationScreenRoute);
                },
                child: Text(
                  "Verified",
                  style: PMT.style(12, fontColor: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, bool isDark, Color textColor, Color subTextColor, Color cardColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.transparent, // Dark mode has card bg, light mode transparent
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(context, "Tokens", "150", Icons.monetization_on_outlined, textColor, subTextColor),
          Container(height: 40, width: 1, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
          _buildStatItem(context, "Bookings", "06", Icons.calendar_month_outlined, textColor, subTextColor),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon, Color textColor, Color subTextColor) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: subTextColor),
            const SizedBox(width: 4),
            Text(label, style: PMT.style(12, fontColor: subTextColor)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: PMT.style(24, fontColor: textColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildVisibilityToggle(BuildContext context, bool isDark, Color textColor, Color cardColor, Color accentColor) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.visibility_outlined, color: accentColor, size: 20),
              const SizedBox(width: 12),
              Text(
                "My Profile Visibility",
                style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Switch(
            value: controller.isProfileVisible.value,
            onChanged: controller.toggleProfileVisibility,
            activeColor: accentColor,
            inactiveTrackColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ],
      ),
    ));
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap, required bool isDark, required Color textColor, required Color cardColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : cardColor,
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
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.grey : Colors.black54),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.logout, color: Colors.red),
      label: Text(
        "Logout",
        style: PMT.style(16, fontColor: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
