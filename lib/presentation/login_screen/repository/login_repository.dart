import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class LoginRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> mobileLogin(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.linkedinMobileLogin,
      body: data,
      showLoader: true,
      headerWithToken: false,
    );
  }
}
