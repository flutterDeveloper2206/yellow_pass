import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:yellow_pass/routes/app_routes.dart';

class CheckInSuccessController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    // Play success sound
    _playSound();
    
    // Simulate auto-connecting to WiFi
    Future.delayed(const Duration(seconds: 2), () {
      // You can show a snackbar or update UI state here
      Get.snackbar("WiFi Connected", "Successfully connected to Cafe WiFi");
    });
  }

  Future<void> _playSound() async {
    try {
      // Replace with your local asset path if available, e.g., 'audio/success.mp3'
      // For now using a network url for demo or placeholder
      // await audioPlayer.play(AssetSource('audio/success.mp3')); 
      
      // Using a short beep or success sound from a public URL if possible, 
      // but for production, use AssetSource.
      // Here we assume the user will add 'assets/audio/success.mp3'
      // If not, this might throw or do nothing. 
      // I'll add a safe check or just comment it out to not crash if file missing.
      
      // Attempting to play a generic success sound from URL for demo
      // await audioPlayer.play(UrlSource('https://assets.mixkit.co/active_storage/sfx/2000/2000-preview.mp3'));

      // Set the release mode to keep the source after playback has completed.
      // audioPlayer.setReleaseMode(ReleaseMode.stop);

      // Start the player as soon as the app is displayed.
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Using a reliable network URL for the success sound
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
    Get.offNamedUntil(AppRoutes.myBookingScreenRoute, (route) => route.isFirst);
  }
}
