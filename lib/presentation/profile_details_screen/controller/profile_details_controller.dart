import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellow_pass/core/utils/commonConstant.dart';
import 'package:yellow_pass/presentation/profile_screen/controller/profile_screen_controller.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';
import '../../../core/utils/shared_prefs.dart';

class ProfileDetailsController extends GetxController {
  RxBool isEditing = false.obs;
  RxBool isUpdating = false.obs;
  Rx<File?> profileImage = Rx<File?>(null);
  RxMap userData = {}.obs;

  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController mobileController;
  late TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    bioController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    loadUserData();
  }

  void loadUserData() {
    final data = SharedPrefs.getUser();
    if (data != null) {
      userData.value = data;
      nameController.text = data['name'] ?? "";
      bioController.text = data['description'] ?? "";
      mobileController.text = data['mobile'] ?? "";
      emailController.text = data['email'] ?? "";
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> toggleEditMode() async {
    if (isEditing.value) {
      // Save changes
      await _updateProfile();
    } else {
      // Enter edit mode
      isEditing.value = true;
    }
  }

  Future<void> _updateProfile() async {
    try {
      isUpdating.value = true;
      
      final profileController = Get.find<ProfileScreenController>();
      
      bool success = await profileController.updateProfile(
        name: nameController.text.trim(),
        mobile: mobileController.text.trim(),
        description: bioController.text.trim(),
        profilePicturePath: profileImage.value?.path,
      );
      
      if (success) {
        CommonSnackbar.showSuccess(message: "Profile updated successfully");
        isEditing.value = false;
        profileImage.value = null; // Reset after successful upload
        loadUserData(); // Reload data
      } else {
        CommonSnackbar.showError(message: "Failed to update profile");
      }
    } catch (e) {
      CommonSnackbar.showError(message: "Error updating profile: $e");
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 50, // Initial quality reduction
      );

      if (image != null) {
        File originalFile = File(image.path);
        
        // Compress to 500 KB using CommonConstant
        File compressedFile = await CommonConstant.instance.compressImage(
          originalFile, 
          500 * 1024, // 500 KB
        );
        
        profileImage.value = compressedFile;
        
        // Show size info
        int sizeInBytes = await compressedFile.length();
        double sizeInKb = sizeInBytes / 1024;
        print("Compressed image size: ${sizeInKb.toStringAsFixed(2)} KB");
      }
    } catch (e) {
      print("Error picking/compressing image: $e");
      CommonSnackbar.showError(message: "Failed to process image");
    }
  }
}
