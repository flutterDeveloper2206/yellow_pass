import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class RegisterRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> registerUser(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.register,
      body: data,
      showLoader: true,
      headerWithToken: false,
    );
  }
}
