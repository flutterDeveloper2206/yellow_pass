import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class NotificationRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getNotifications() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.notificationsApi,
      showLoader: false,
      headerWithToken: true,
    );
  }
}
