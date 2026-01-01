import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';
import '../repository/search_repository.dart';

class SearchScreenController extends GetxController {
  final SearchRepository _repository = SearchRepository();
  
  final TextEditingController searchController = TextEditingController();
  final RxString updateSearchQuery = ''.obs;
  
  final RxList<Cafe> searchResults = <Cafe>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(updateSearchQuery, (callback) {
      if (updateSearchQuery.value.isNotEmpty) {
        searchCafes(updateSearchQuery.value);
      } else {
        searchResults.clear();
        isSearching.value = false;
      }
    }, time: const Duration(milliseconds: 500));
  }

  void onSearchChanged(String query) {
    updateSearchQuery.value = query;
  }

  void clearSearch() {
    searchController.clear();
    updateSearchQuery.value = '';
    searchResults.clear();
    isSearching.value = false;
  }

  Future<void> searchCafes(String query) async {
    isLoading.value = true;
    isSearching.value = true;
    try {
      final response = await _repository.searchCafes(query);
      if (response != null) {
        CafeResponse cafeResponse = CafeResponse.fromJson(response);
        if (cafeResponse.status == true && cafeResponse.data != null) {
          searchResults.value = cafeResponse.data!;
        } else {
          searchResults.clear();
        }
      } else {
         searchResults.clear();
      }
    } catch (e) {
      debugPrint("Error searching cafes: $e");
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
