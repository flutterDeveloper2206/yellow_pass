import 'package:get/get.dart';
import '../../../ApiServices/api_end_points.dart';
import '../../../ApiServices/api_service.dart';

class NearbyRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getNearbyUsers({
    required double latitude,
    required double longitude,
  }) async {
    return await _apiService.callGetApi(
      url: '${ApiEndPoints.nearbyUsers}?latitude=$latitude&longitude=$longitude',
      showLoader: false,
      headerWithToken: true,
    );
  }

  Future<dynamic> getNearbyCafes({
    required double latitude,
    required double longitude,
    String? category,
  }) async {
    final categoryParam = category ?? 'null';
    return await _apiService.callGetApi(
      url: '${ApiEndPoints.nearbyCafes}?category=$categoryParam&lat=$latitude&lng=$longitude',
      showLoader: false,
      headerWithToken: true,
    );
  }
}
