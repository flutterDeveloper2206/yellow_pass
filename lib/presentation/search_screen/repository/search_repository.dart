import 'package:get/get.dart';
import 'package:yellow_pass/ApiServices/api_end_points.dart';
import 'package:yellow_pass/ApiServices/api_service.dart';

class SearchRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> searchCafes(String query) async {
    return await _apiService.callGetApi(
      url: "${ApiEndPoints.cafesApi}?search=$query",
      showLoader: false,
      headerWithToken: true,
    );
  }
}
