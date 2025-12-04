import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ProfileDetailsController extends GetxController {
  RxBool isEditing = false.obs;
  Rx<File?> profileImage = Rx<File?>(null);

  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController mobileController;
  late TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: "Vaishnavi Shrivat");
    bioController = TextEditingController(
        text: "UI/UX Designer | Business Understanding | Exploring Frontend Development | Integrating AI for Seamless, Data-Driven Experiences");
    mobileController = TextEditingController(text: "+91 8605927522");
    emailController = TextEditingController(text: "vaishushrivat@gmail.com");
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        await _cropImage(image.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  Future<void> _cropImage(String path) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        await _compressImage(croppedFile.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to crop image: $e");
    }
  }

  Future<void> _compressImage(String path) async {
    try {
      // Compress to approx 500kb. 
      // We start with a quality and check size, but for simplicity here we use a fixed quality 
      // which usually reduces size significantly.
      final targetPath = '${path}_compressed.jpg';
      var result = await FlutterImageCompress.compressAndGetFile(
        path,
        targetPath,
        quality: 70, // Adjust quality to manage size
      );

      if (result != null) {
        File compressedFile = File(result.path);
        int sizeInBytes = await compressedFile.length();
        double sizeInKb = sizeInBytes / 1024;
        
        if (sizeInKb > 500) {
           // If still > 500kb, compress again with lower quality
           var result2 = await FlutterImageCompress.compressAndGetFile(
            path,
            targetPath,
            quality: 50, 
          );
          if (result2 != null) {
             profileImage.value = File(result2.path);
          }
        } else {
          profileImage.value = compressedFile;
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to compress image: $e");
    }
  }
}
