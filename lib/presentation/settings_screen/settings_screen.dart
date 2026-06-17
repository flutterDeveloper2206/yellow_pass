import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/settings_screen/controller/settings_controller.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late SettingsController controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SettingsController());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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

    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final accentColor = ColorConstant.primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              _buildAppBar(context, textColor, isDark),
              const SizedBox(height: 30),
              _buildAnimatedItem(
                  0,
                  _buildThemeItem(
                      context, isDark, textColor, cardColor, accentColor)),
              _buildAnimatedItem(
                  1,
                  _buildNotificationItem(
                      context, isDark, textColor, cardColor, accentColor)),
              _buildAnimatedItem(
                  2,
                  _buildMenuItem(context,
                      icon: Icons.history_edu,
                      title: "Privacy Policy",
                      onTap: () => _launchURL("https://yellowpass.in/privacy-policy"),
                      isDark: isDark,
                      textColor: textColor,
                      cardColor: cardColor)),
              _buildAnimatedItem(
                  3,
                  _buildMenuItem(context,
                      icon: Icons.history_edu,
                      title: "Terms & Conditions",
                      onTap: () => _launchURL("https://yellowpass.in/terms-and-conditions"),
                      isDark: isDark,
                      textColor: textColor,
                      cardColor: cardColor)),
              _buildAnimatedItem(
                  4,
                  _buildMenuItem(context,
                      icon: Icons.history,
                      title: "About Us",
                      onTap: () {},
                      isDark: isDark,
                      textColor: textColor,
                      cardColor: cardColor)),
              _buildAnimatedItem(
                  5,
                  _buildMenuItem(context,
                      icon: Icons.history,
                      title: "Contact Us",
                      onTap: () {},
                      isDark: isDark,
                      textColor: textColor,
                      cardColor: cardColor)),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final animation = CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (index * 0.1),
            1.0,
            curve: Curves.easeOut,
          ),
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: child,
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
              "Settings",
              style: PMT.style(18,
                  fontColor: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeItem(BuildContext context, bool isDark, Color textColor,
      Color cardColor, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? []
            : [
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
              Icon(Icons.history,
                  color: isDark ? Colors.grey : Colors.grey,
                  size:
                      20), // Using history icon as placeholder for 'Theme' icon in design
              const SizedBox(width: 12),
              Text(
                "Theme",
                style: PMT.style(14,
                    fontColor: textColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          GestureDetector(
            onTap: controller.toggleTheme,
            child: Container(
              width: 50,
              height: 28,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: isDark ? 24 : 2,
                    top: 2,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Colors.transparent : Colors.white,
                      ),
                      child: isDark
                          ? const Icon(Icons.nightlight_round,
                              size: 16, color: Colors.grey)
                          : const Icon(Icons.wb_sunny,
                              size: 16, color: ColorConstant.primaryColor),
                    ),
                  ),
                  if (isDark)
                    const Positioned(
                      left: 6,
                      top: 6,
                      child: Icon(Icons.wb_sunny,
                          size: 16, color: Colors.grey), // Inactive sun
                    ),
                  if (!isDark)
                    const Positioned(
                      right: 6,
                      top: 6,
                      child: Icon(Icons.nightlight_round,
                          size: 16, color: Colors.grey), // Inactive moon
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, bool isDark,
      Color textColor, Color cardColor, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8), // Adjusted padding for Switch
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? []
            : [
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
              Icon(Icons.history,
                  color: isDark ? Colors.grey : Colors.grey, size: 20),
              const SizedBox(width: 12),
              Text(
                "Notifications",
                style: PMT.style(14,
                    fontColor: textColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Obx(() => Switch(
                value: controller.isNotificationsEnabled.value,
                onChanged: controller.toggleNotifications,
                activeTrackColor: accentColor,
                activeThumbColor: Colors.black,
                inactiveTrackColor:
                    isDark ? Colors.grey.shade800 : Colors.grey.shade300,
              )),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      required bool isDark,
      required Color textColor,
      required Color cardColor,
      Color? iconColor,
      Color? titleColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ListTile(
        onTap: onTap,
        leading:
            Icon(icon, color: iconColor ?? (isDark ? Colors.grey : Colors.grey), size: 20),
        title: Text(
          title,
          style:
              PMT.style(14, fontColor: titleColor ?? textColor, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            size: 16, color: titleColor ?? (isDark ? Colors.grey : Colors.black54)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }



  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not launch URL");
    }
  }
}
