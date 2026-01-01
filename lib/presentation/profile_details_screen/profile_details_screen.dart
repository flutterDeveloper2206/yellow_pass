import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/profile_details_screen/controller/profile_details_controller.dart';

class ProfileDetailsScreen extends GetView<ProfileDetailsController> {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Define colors based on screenshot
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final inputFillColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final accentColor =  Colors.yellow; // Yellow

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              _buildAppBar(context, textColor, isDark),
              const SizedBox(height: 30),
              _buildProfileHeader(context, textColor, subTextColor, accentColor),
              const SizedBox(height: 30),
              _buildForm(context, isDark, textColor, subTextColor, inputFillColor, accentColor),
              const SizedBox(height: 40),
              _buildActionButton(context, isDark, textColor, accentColor),
              const SizedBox(height: 20),
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
            Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                controller.isEditing.value ? "Edit Details" : "My Details",
                key: ValueKey(controller.isEditing.value),
                style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
              ),
            )),
          ],
        ),
        const Row(
          children: [
            // Visibility icon removed
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
                  style: BorderStyle.solid 
                ),
              ),
              child: Obx(() {
                if (controller.profileImage.value != null) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(controller.profileImage.value!),
                  );
                } else if (controller.userData['profile_picture'] != null && controller.userData['profile_picture'].toString().isNotEmpty) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("${controller.userData['profile_picture']}"),
                  );
                } else {
                  return const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/profiles.png',
                    ),
                  );
                }
              }),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (controller.isEditing.value) {
                    _showImagePickerOptions(context);
                  }
                },
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
            ),
          ],
        ),
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
        // Bio is moved to form in this design, but kept short description here if needed, 
        // or we can hide it if it's redundant with the form field. 
        // Based on screenshot, the bio text is below title in View mode, but inside field in Edit mode?
        // Actually screenshot shows Bio field. Let's keep the header simple.
        Obx(() => controller.isEditing.value 
          ? const SizedBox.shrink()
          : Column(
              children: [
                Obx(() => Text(
                  controller.userData['description'] ?? "No Bio Added",
                  textAlign: TextAlign.center,
                  style: PMT.style(11, fontColor: subTextColor, fontWeight: FontWeight.w400),
                )),
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
                      Text(
                        "Verified",
                        style: PMT.style(12, fontColor: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, bool isDark, Color textColor, Color subTextColor, Color inputFillColor, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio Field (Only visible in Edit mode based on screenshot flow, or always visible? 
        // Screenshot shows "Bio" label in Edit mode. In View mode it's under the profile pic.
        // Let's make it always visible in form for consistency or follow screenshot strictly.)
        // Screenshot 3 (Edit Details) shows Bio field. Screenshot 1 (My Details) shows text under profile.
        // So we toggle visibility of the Bio FIELD.
        Obx(() => AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bio", style: PMT.style(12, fontColor: subTextColor)),
              const SizedBox(height: 8),
              _buildTextField(
                controller: controller.bioController,
                isDark: isDark,
                textColor: textColor,
                fillColor: inputFillColor,
                maxLines: 4,
                enabled: true, // Always enabled if visible in edit mode
              ),
              const SizedBox(height: 20),
            ],
          ),
          crossFadeState: controller.isEditing.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        )),

        Text("Full Name", style: PMT.style(12, fontColor: subTextColor)),
        const SizedBox(height: 8),
        Obx(() => _buildTextField(
          controller: controller.nameController,
          isDark: isDark,
          textColor: textColor,
          fillColor: inputFillColor,
          enabled: controller.isEditing.value,
        )),
        const SizedBox(height: 20),

        Text("Mobile Number", style: PMT.style(12, fontColor: subTextColor)),
        const SizedBox(height: 8),
        Obx(() => _buildTextField(
          controller: controller.mobileController,
          isDark: isDark,
          textColor: textColor,
          fillColor: inputFillColor,
          enabled: controller.isEditing.value,
        )),
        const SizedBox(height: 20),

        Text("Email ID", style: PMT.style(12, fontColor: subTextColor)),
        const SizedBox(height: 8),
        Obx(() => _buildTextField(
          controller: controller.emailController,
          isDark: isDark,
          textColor: textColor,
          fillColor: inputFillColor,
          enabled: controller.isEditing.value,
        )),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required bool isDark,
    required Color textColor,
    required Color fillColor,
    bool enabled = false,
    int maxLines = 1,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled 
              ? (isDark ? Colors.grey.shade600 : Colors.grey.shade300) 
              : Colors.transparent,
        ),
        boxShadow: enabled || isDark ? [] : [
           BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, bool isDark, Color textColor, Color accentColor) {
    return Obx(() => SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.isUpdating.value ? null : () {
          controller.toggleEditMode();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isEditing.value 
              ? (isDark ? Colors.white : Colors.black) 
              : (isDark ? Colors.white : Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: controller.isUpdating.value
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark ? Colors.black : Colors.white,
                  ),
                ),
              )
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  controller.isEditing.value ? "Update Profile" : "Edit Profile",
                  key: ValueKey(controller.isEditing.value),
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    ));
  }

  void _showImagePickerOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
