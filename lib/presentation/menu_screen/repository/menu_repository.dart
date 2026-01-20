import 'package:get/get.dart';
import '../../../ApiServices/api_end_points.dart';
import '../../../ApiServices/api_service.dart';

class MenuRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> placeOrder(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.orders,
      body: data,
      showLoader: true,
      headerWithToken: true,
    );
  }
}
