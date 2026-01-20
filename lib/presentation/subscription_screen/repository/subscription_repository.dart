import 'package:get/get.dart';
import '../../../ApiServices/api_end_points.dart';
import '../../../ApiServices/api_service.dart';

class SubscriptionRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getSubscriptions() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.subscriptions,
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> initiateSubscription(int subscriptionId) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.initiateSubscription,
      body: {'subscription_id': subscriptionId},
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> verifySubscription(Map<String, dynamic> data) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.verifySubscription,
      body: data,
      showLoader: true,
      headerWithToken: true,
    );
  }
}
