import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/support_screen/controller/support_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
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

                final info = controller.contactInfo.value;
                final email = (info?.email != null && info!.email!.isNotEmpty)
                    ? info.email!
                    : "hello@yellowpass.in";
                final phone = (info?.phone != null && info!.phone!.isNotEmpty)
                    ? info.phone!
                    : "9909911990";
                final address =
                    (info?.address != null && info!.address!.isNotEmpty)
                        ? info.address!
                        : "804 Aalap-A, limda choak , Rajkot ,Gujarat -380001";
                final supportHours = (info?.supportHours != null &&
                        info!.supportHours!.isNotEmpty)
                    ? info.supportHours!
                    : "10:00 AM - 7:00 PM";

                final facebookUrl = (info?.socialMedia?.facebook != null &&
                        info!.socialMedia!.facebook!.isNotEmpty)
                    ? info.socialMedia!.facebook!
                    : "https://www.facebook.com/share/1Y5ZBDQx6t/";
                final twitterUrl = info?.socialMedia?.twitter;
                final instagramUrl = (info?.socialMedia?.instagram != null &&
                        info!.socialMedia!.instagram!.isNotEmpty)
                    ? info.socialMedia!.instagram!
                    : "https://www.instagram.com/yellowpass.in/";
                final linkedinUrl = (info?.socialMedia?.linkedin != null &&
                        info!.socialMedia!.linkedin!.isNotEmpty)
                    ? info.socialMedia!.linkedin!
                    : "https://www.linkedin.com/company/yellowpass/";

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How can we help you?",
                        style: PMT.style(24,
                            fontColor: textColor, fontWeight: FontWeight.bold),
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
                        value: email,
                        isDark: isDark,
                        cardColor: cardColor,
                        onTap: () => _launchUrl("mailto:$email"),
                      ),
                      _buildContactCard(
                        context,
                        icon: Icons.phone_outlined,
                        title: "Phone",
                        value: phone,
                        isDark: isDark,
                        cardColor: cardColor,
                        onTap: () => _launchUrl("tel:$phone"),
                      ),
                      _buildContactCard(
                        context,
                        icon: Icons.location_on_outlined,
                        title: "Address",
                        value: address,
                        isDark: isDark,
                        cardColor: cardColor,
                      ),
                      const SizedBox(height: 20),
                      _buildSupportHours(
                          context, supportHours, isDark, cardColor),
                      const SizedBox(height: 30),
                      Text(
                        "Follow Us",
                        style: PMT.style(18,
                            fontColor: textColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildSocialMediaRow(
                        facebook: facebookUrl,
                        twitter: twitterUrl,
                        instagram: instagramUrl,
                        linkedin: linkedinUrl,
                      ),
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
            style: PMT.style(18,
                fontColor: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String value,
      required bool isDark,
      required Color cardColor,
      VoidCallback? onTap}) {
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
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstant.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: ColorConstant.primaryColor, size: 24),
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
                    style: PMT.style(14,
                        fontColor: textColor, fontWeight: FontWeight.w600),
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

  Widget _buildSupportHours(
      BuildContext context, String hours, bool isDark, Color cardColor) {
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorConstant.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time,
              color: ColorConstant.primaryColor, size: 20),
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
                  style: PMT.style(14,
                      fontColor: textColor, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaRow({
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  }) {
    return Row(
      children: [
        if (facebook != null && facebook.isNotEmpty)
          _buildSocialIcon(Icons.facebook, Colors.blue, facebook),
        if (instagram != null && instagram.isNotEmpty)
          _buildSocialIcon(Icons.camera_alt_outlined, Colors.pink, instagram),
        if (linkedin != null && linkedin.isNotEmpty)
          _buildSocialIcon(Icons.work_outline, Colors.blue.shade800, linkedin),
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
