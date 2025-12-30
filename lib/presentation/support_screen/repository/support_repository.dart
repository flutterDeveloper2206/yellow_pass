import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class SupportRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getContactInfo() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.contactInfoApi,
      showLoader: false,
      headerWithToken: true,
    );
  }
}
