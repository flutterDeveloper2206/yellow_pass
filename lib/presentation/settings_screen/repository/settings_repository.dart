import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class SettingsRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> deleteAccount() async {
    return await _apiService.callDeleteApi(
      url: ApiEndPoints.userProfileApi,
      showLoader: true,
      headerWithToken: true,
    );
  }
}
