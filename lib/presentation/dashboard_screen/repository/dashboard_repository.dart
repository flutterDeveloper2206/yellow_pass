import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class DashboardRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getUserProfile() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.userProfileApi,
      showLoader: false, // Could be true if we want to block UI
      headerWithToken: true,
    );
  }
  Future<dynamic> updateLocation({required double latitude, required double longitude}) async {
    return await _apiService.callPutApi(
      url: ApiEndPoints.updateLocation,
      body: {
        "latitude": latitude,
        "longitude": longitude
      },
      showLoader: false,
      headerWithToken: true,
    );
  }

  Future<dynamic> updateVisibility({required bool isPublic}) async {
    return await _apiService.callPutApi(
      url: ApiEndPoints.updateVisibilityApi,
      body: {
        "is_public": isPublic
      },
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> updateProfile({
    required Map<String, String> fields,
    List<Map<String, String>>? files,
  }) async {
    return await _apiService.uploadMultipart(
      url: ApiEndPoints.userProfileApi,
      fields: fields,
      files: files,
      showLoader: true,
      headerWithToken: true,
    );
  }
}
