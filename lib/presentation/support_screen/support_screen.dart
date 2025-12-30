import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/support_screen/controller/support_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

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
        child: Column(
          children: [
            _buildAppBar(context, textColor),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.contactInfo.value == null) {
                  return Center(
                    child: Text(
                      "Something went wrong while fetching support details.",
                      style: PMT.style(14, fontColor: subTextColor),
                    ),
                  );
                }

                final info = controller.contactInfo.value!;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How can we help you?",
                        style: PMT.style(24, fontColor: textColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We're here to assist you with any questions or issues you may have.",
                        style: PMT.style(14, fontColor: subTextColor),
                      ),
                      const SizedBox(height: 30),
                      
                      _buildContactCard(
                        context,
                        icon: Icons.email_outlined,
                        title: "Email Support",
                        value: info.email ?? "",
                        isDark: isDark,
                        cardColor: cardColor,
                        onTap: () => _launchUrl("mailto:${info.email}"),
                      ),
                      
                      _buildContactCard(
                        context,
                        icon: Icons.phone_outlined,
                        title: "Phone",
                        value: info.phone ?? "",
                        isDark: isDark,
                        cardColor: cardColor,
                        onTap: () => _launchUrl("tel:${info.phone}"),
                      ),
                      
                      _buildContactCard(
                        context,
                        icon: Icons.location_on_outlined,
                        title: "Address",
                        value: info.address ?? "",
                        isDark: isDark,
                        cardColor: cardColor,
                      ),
                      
                      const SizedBox(height: 20),
                      _buildSupportHours(context, info.address ?? "", isDark, cardColor),
                      
                      const SizedBox(height: 30),
                      Text(
                        "Follow Us",
                        style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildSocialMediaRow(info.socialMedia),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios, size: 20, color: textColor),
          ),
          const SizedBox(width: 8),
          Text(
            "Customer Support",
            style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, {required IconData icon, required String title, required String value, required bool isDark, required Color cardColor, VoidCallback? onTap}) {
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark ? [] : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.yellow, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: PMT.style(12, fontColor: subTextColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.arrow_forward_ios, size: 14, color: subTextColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportHours(BuildContext context, String hours, bool isDark, Color cardColor) {
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.yellow.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: Colors.yellow, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Support Hours",
                  style: PMT.style(12, fontColor: subTextColor),
                ),
                const SizedBox(height: 4),
                Text(
                  hours,
                  style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaRow(socialMedia) {
    if (socialMedia == null) return const SizedBox();
    
    return Row(
      children: [
        if (socialMedia.facebook != null)
          _buildSocialIcon(Icons.facebook, Colors.blue, socialMedia.facebook),
        if (socialMedia.twitter != null)
          _buildSocialIcon(Icons.alternate_email, Colors.lightBlue, socialMedia.twitter),
        if (socialMedia.instagram != null)
          _buildSocialIcon(Icons.camera_alt_outlined, Colors.pink, socialMedia.instagram),
        if (socialMedia.linkedin != null)
          _buildSocialIcon(Icons.work_outline, Colors.blue.shade800, socialMedia.linkedin),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
