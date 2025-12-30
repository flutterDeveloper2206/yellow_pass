import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class AuthRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> sendEmailOtp() async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.sendEmailOtp,
      body: {},
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> confirmEmailOtp(String otp) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.confirmEmailOtp,
      body: {"otp": otp},
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> sendMobileOtp(String mobile) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.sendMobileOtp,
      body: {"mobile": mobile},
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> confirmMobileOtp(String otp) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.confirmMobileOtp,
      body: {"otp": otp},
      showLoader: true,
      headerWithToken: true,
    );
  }
}
