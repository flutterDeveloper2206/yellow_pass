import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../../data/models/cafe_response_model.dart';
import '../../../data/models/nearby_users_response_model.dart';
import '../../../core/utils/commonConstant.dart';
import '../repository/nearby_repository.dart';

class NearbyController extends GetxController {
  final NearbyRepository _repository = Get.put(NearbyRepository());

  final RxList<Cafe> nearbyCafes = <Cafe>[].obs;
  final RxList<NearbyUser> nearbyCoWorkers = <NearbyUser>[].obs;

  final RxBool isLoadingCafes = false.obs;
  final RxBool isLoadingCoWorkers = false.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchAllNearbyData();
  }

  Future<void> fetchAllNearbyData() async {
    try {
      Position? position = await CommonConstant.instance.getCurrentLocation();
      if (position != null) {
        fetchNearbyCafes(position.latitude, position.longitude);
        fetchNearbyUsers(position.latitude, position.longitude);
      } else {
        // Fallback to default coordinates if location fails (using user's example)
        fetchNearbyCafes(23.0104946, 72.5284369);
        fetchNearbyUsers(23.0104946, 72.5284369);
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
      // Fallback
      fetchNearbyCafes(23.0104946, 72.5284369);
      fetchNearbyUsers(23.0104946, 72.5284369);
    }
  }

  Future<void> fetchNearbyCafes(double lat, double lng) async {
    try {
      isLoadingCafes.value = true;
      final response = await _repository.getNearbyCafes(
        latitude: lat,
        longitude: lng,
      );

      if (response != null && response['status'] == true) {
        final cafeResponse = CafeResponse.fromJson(response);
        nearbyCafes.assignAll(cafeResponse.data ?? []);
      }
    } catch (e) {
      debugPrint("Error fetching nearby cafes: $e");
    } finally {
      isLoadingCafes.value = false;
    }
  }

  Future<void> fetchNearbyUsers(double lat, double lng) async {
    try {
      isLoadingCoWorkers.value = true;
      final response = await _repository.getNearbyUsers(
        latitude: lat,
        longitude: lng,
      );

      if (response != null && response['status'] == true) {
        final usersResponse = NearbyUsersResponse.fromJson(response);
        nearbyCoWorkers.assignAll(usersResponse.data ?? []);
      }
    } catch (e) {
      debugPrint("Error fetching nearby users: $e");
    } finally {
      isLoadingCoWorkers.value = false;
    }
  }
}
