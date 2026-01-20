import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/app_fonts.dart';
import '../../widgets/bouncing_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../ApiServices/api_end_points.dart';
import '../../core/utils/color_constant.dart';
import 'controller/other_profile_controller.dart';
import '../../widgets/common_snackbar.dart';

class OtherProfileScreen extends GetView<OtherProfileController> {
  const OtherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final profilePic = user.profilePicture ??
        "${ApiEndPoints.imageBaseUrl}/storage/profile-pictures/default.png";
    final fullProfilePic = profilePic.startsWith("http")
        ? profilePic
        : "${ApiEndPoints.imageBaseUrl}$profilePic";

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Small Profile Pic
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Background Header
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDarkMode
                              ? [
                                  const Color(0xFF1E1E1E),
                                  const Color(0xFF121212)
                                ]
                              : [
                                  ColorConstant.primaryColor,
                                  ColorConstant.primaryColor.withOpacity(0.7)
                                ],
                        ),
                      ),
                    ),
                    // Profile Picture
                    Positioned(
                      bottom: -50,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF121212)
                              : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CustomImageView(
                            url: fullProfilePic,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // Details Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user.name ?? "Anonymous",
                        textAlign: TextAlign.center,
                        style: PMT.style(32,
                            fontColor: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.description ?? "Co-worker at Yellow Pass",
                        textAlign: TextAlign.center,
                        style: PMT.style(16,
                            fontColor: isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade600),
                      ),
                      const SizedBox(height: 12),
                      if (user.distance != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: ColorConstant.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${user.distance!.toStringAsFixed(1)} km away",
                            style: PMT.style(14,
                                fontColor: ColorConstant.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      const SizedBox(height: 32),

                      // About Me Section
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About",
                              style: PMT.style(20,
                                  fontColor:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Hi there! I'm using Yellow Pass to find great workspaces and connect with fellow professionals. Let's collaborate!",
                              style: PMT.style(14,
                                  fontColor: isDarkMode
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 100), // Space for button
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: Bounce(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ),

          // Request Meeting Button
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Bounce(
              onTap: () => _showMessageSheet(context, user.id),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.primaryColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.handshake_rounded, color: Colors.black),
                      const SizedBox(width: 12),
                      Text(
                        "Request for Meeting",
                        style: PMT.style(16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
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

  void _showMessageSheet(BuildContext context, int? userId) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController messageController = TextEditingController(
        text:
            "Hey, I saw you work in ${controller.user.description ?? 'the same field'}. Want to connect?");

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send Request",
              style: PMT.style(20,
                  fontColor: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Add a personal message to connect better.",
              style: PMT.style(14, fontColor: Colors.grey.shade500),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: messageController,
              maxLines: 4,
              style: PMT.style(14,
                  fontColor: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: PMT.style(14, fontColor: Colors.grey),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 24),
            Obx(() => Bounce(
                  onTap: () {
                    if (messageController.text.trim().isNotEmpty) {
                      controller.requestMeeting(
                          userId, messageController.text.trim());
                    } else {
                      CommonSnackbar.showError(
                          message: "Please enter a message");
                    }
                  },
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                  color: Colors.black, strokeWidth: 2),
                            )
                          : Text(
                              "Send Request",
                              style: PMT.style(16,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
