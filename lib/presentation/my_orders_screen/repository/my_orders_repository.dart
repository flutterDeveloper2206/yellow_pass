import 'package:get/get.dart';
import '../../../ApiServices/api_end_points.dart';
import '../../../ApiServices/api_service.dart';

class MyOrdersRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getOrders() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.orders,
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> cancelOrder(String orderId) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.cancelOrder(orderId),
      body: {},
      showLoader: true,
      headerWithToken: true,
    );
  }
}
