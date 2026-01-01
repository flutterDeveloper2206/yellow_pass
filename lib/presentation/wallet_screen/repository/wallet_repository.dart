import 'package:get/get.dart';
import 'package:yellow_pass/ApiServices/api_end_points.dart';
import 'package:yellow_pass/ApiServices/api_service.dart';

class WalletRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> buyTokens(int amount) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.buyTokens,
      body: {'amount_rs': amount},
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> verifyTokens(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.verifyTokens,
      body: data,
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> getTransactionHistory() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.transactionHistoryApi,
      showLoader: false,
      headerWithToken: true,
    );
  }
}
