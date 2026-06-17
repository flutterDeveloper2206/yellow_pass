import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;
  final isNotificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications(bool value) {
    isNotificationsEnabled.value = value;
  }
}
