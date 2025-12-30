import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/data/models/category_response_model.dart';
import '../../../core/utils/shared_prefs.dart';
import '../../dashboard_screen/repository/dashboard_repository.dart';
import '../repository/home_repository.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';

class HomeScreenController extends GetxController {
  final HomeRepository _homeRepository = Get.put(HomeRepository());
  
  RxInt currentIndex = 0.obs;
  RxInt selectedCategoryIndex = 0.obs;
  RxMap userData = {}.obs;
  RxBool isProfileVisible = false.obs;
  RxList<String> categories = <String>["All"].obs;
  RxBool isCafeLoading = false.obs;
  RxList<Cafe> cafes = <Cafe>[].obs;
  RxList<Cafe> filteredCafes = <Cafe>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchCategories();
    fetchCafes();
  }

  void loadUserData() {
    final data = SharedPrefs.getUser();
    if (data != null) {
      userData.value = data;
      isProfileVisible.value = data['is_public'] is bool ? data['is_public'] : (data['is_public'] == 1);
    }
  }

  Future<void> fetchCategories() async {
    try {
      debugPrint("HOME_CONTROLLER: Fetching categories...");
      final response = await _homeRepository.getCategories();
      
      if (response != null && (response['status'] == true || response['status_code'] == 200)) {
        final categoryResponse = CategoryResponse.fromJson(response);
        if (categoryResponse.data != null) {
          // Keep "All" and add new categories, avoiding duplicates
          final List<String> fetched = categoryResponse.data!;
          categories.assignAll(["All", ...fetched]);
          debugPrint("HOME_CONTROLLER: Categories loaded: ${categories.length}");
        }
      }
    } catch (e) {
      debugPrint("HOME_CONTROLLER: Error fetching categories: $e");
    }
  }

  Future<void> fetchCafes() async {
    try {
      debugPrint("HOME_CONTROLLER: Fetching cafes...");
      isCafeLoading.value = true;
      final response = await _homeRepository.getCafes();
      debugPrint("HOME_CONTROLLER: Cafes Response: $response");
      
      if (response != null && (response['status'] == true || response['status_code'] == 200)) {
        final cafeResponse = CafeResponse.fromJson(response);
        if (cafeResponse.data != null) {
          cafes.assignAll(cafeResponse.data!);
          filterCafes(selectedCategoryIndex.value); // Set data category wise
          debugPrint("HOME_CONTROLLER: Cafes loaded: ${cafes.length}");
        }
      } else {
        debugPrint("HOME_CONTROLLER: Cafes API failed or status not true");
      }
    } catch (e) {
      isCafeLoading.value = false;

      debugPrint("HOME_CONTROLLER: Error fetching cafes: $e");
    } finally {
      isCafeLoading.value = false;
      debugPrint("HOME_CONTROLLER: Cafe loading finished. isCafeLoading: ${isCafeLoading.value}");
    }
  }

  Future<void> toggleVisibility(bool value) async {
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
      debugPrint("Error updating visibility: $e");
    }
  }

  void filterCafes(int index) {
    selectedCategoryIndex.value = index;
    if (categories.isEmpty) return;
    
    final selectedCategory = categories[index];
    
    if (selectedCategory == "All") {
      filteredCafes.assignAll(cafes);
      debugPrint("HOME_CONTROLLER: Showing all cafes - ${filteredCafes.length}");
    } else {
      final filtered = cafes.where((cafe) => 
        cafe.category?.trim().toLowerCase() == selectedCategory.trim().toLowerCase()
      ).toList();
      filteredCafes.assignAll(filtered);
      debugPrint("HOME_CONTROLLER: Filtered for '$selectedCategory' - Found ${filtered.length}");
    }
  }

  List<Cafe> get featuredCafes {
    return cafes;
  }

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.receipt_long_outlined,
    Icons.send_time_extension_outlined,
    Icons.person_2_outlined,
  ];
}
