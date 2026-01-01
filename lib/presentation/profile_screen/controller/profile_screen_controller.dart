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

  Future<void> fetchProfile() async {
     try {
       final repository = Get.find<DashboardRepository>();
       final dynamic response = await repository.getUserProfile();
      
       if (response != null && response['status'] == true) {
         if (response['data'] != null ) {
           await SharedPrefs.setUser(response['data']);
           loadUserData();
         }
       }
     } catch (e) {
       debugPrint("Error fetching profile: $e");
     }
  }

  Future<bool> updateProfile({
    required String name,
    required String mobile,
    String? description,
    String? profilePicturePath,
  }) async {
    try {
      final repository = Get.find<DashboardRepository>();
      
      final fields = <String, String>{
        'name': name,
        'mobile': mobile,
      };
      
      if (description != null && description.isNotEmpty) {
        fields['description'] = description;
      }
      
      List<Map<String, String>>? files;
      if (profilePicturePath != null && profilePicturePath.isNotEmpty) {
        files = [
          {
            'field': 'profile_picture',
            'path': profilePicturePath,
          }
        ];
      }
      
      final dynamic response = await repository.updateProfile(
        fields: fields,
        files: files,
      );
      
      if (response != null && response['status'] == true) {
        if (response['data'] != null && response['data']['user'] != null) {
          await SharedPrefs.setUser(response['data']['user']);
          loadUserData();
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint("Error updating profile: $e");
      return false;
    }
  }
}
