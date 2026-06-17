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

  Future<dynamic> emailLogin(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.login,
      body: data,
      showLoader: true,
      headerWithToken: false,
    );
  }

  Future<dynamic> forgotPassword(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.forgotPassword,
      body: data,
      showLoader: true,
      headerWithToken: false,
    );
  }

  Future<dynamic> resetPassword(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.resetPassword,
      body: data,
      showLoader: true,
      headerWithToken: false,
    );
  }
}
