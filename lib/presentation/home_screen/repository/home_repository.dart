import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class HomeRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getCategories() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.cafesCategories,
      showLoader: false,
      headerWithToken: true,
    );
  }

  Future<dynamic> getCafes() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.cafesApi,
      showLoader: false,
      headerWithToken: true,
    );
  }
}
