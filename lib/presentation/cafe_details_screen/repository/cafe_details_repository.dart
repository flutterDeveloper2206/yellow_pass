import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class CafeDetailsRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getCafeDetails(String id) async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.cafeDetails(id),
      showLoader: false,
      headerWithToken: true,
    );
  }
}
