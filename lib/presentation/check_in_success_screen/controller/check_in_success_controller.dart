import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/routes/app_routes.dart';

class CheckInSuccessController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  
  RxBool isSuccess = true.obs;
  RxString message = "".obs;
  RxString cafeName = "".obs;
  RxString title = "".obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get arguments
    if (Get.arguments != null && Get.arguments is Map) {
      isSuccess.value = Get.arguments['isSuccess'] ?? true;
      message.value = Get.arguments['message'] ?? "";
      cafeName.value = Get.arguments['cafeName'] ?? "the Cafe";
      title.value = Get.arguments['title'] ?? (isSuccess.value ? "Check-in Successful!" : "Check-in Failed");
    }

    if (isSuccess.value) {
      _playSound();
      
      // Simulate auto-connecting to WiFi
      Future.delayed(const Duration(seconds: 2), () {
        Get.snackbar("WiFi Connected", "Successfully connected to Cafe WiFi");
      });
    }
  }

  Future<void> _playSound() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await audioPlayer.play(UrlSource('https://assets.mixkit.co/active_storage/sfx/2000/2000-preview.mp3'));
      });
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void onContinue() {
    Get.back();
  }
}
