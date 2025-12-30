import 'package:get/get.dart';
import 'package:yellow_pass/presentation/dashboard_screen/repository/dashboard_repository.dart';
import '../../../core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class ProfileScreenController extends GetxController {
  RxBool isProfileVisible = true.obs;
  RxMap userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final data = SharedPrefs.getUser();
    if (data != null) {
      userData.value = data;
      isProfileVisible.value = data['is_public'] is bool ? data['is_public'] : (data['is_public'] == 1);
    }
  }

  Future<void> toggleProfileVisibility(bool value) async {
    try {
      final repository = Get.find<DashboardRepository>();
      final dynamic response = await repository.updateVisibility(isPublic: value);
      
      if (response != null && response['status'] == true) {
        isProfileVisible.value = value;
        if (response['data'] != null && response['data']['user'] != null) {
          await SharedPrefs.setUser(response['data']['user']);
          loadUserData();
        }
      }
    } catch (e) {
      debugPrint("Error updating profile visibility: $e");
    }
  }
}
