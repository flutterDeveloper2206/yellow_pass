import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class MyBookingRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getBookingDetails(String bookingId) async {
    return await _apiService.callGetApi(
      url: "${ApiEndPoints.bookings}/$bookingId",
      showLoader: false,
      headerWithToken: true,
    );
  }

  Future<dynamic> checkIn(Map<String, dynamic> body) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.checkIn,
      body: body,
      showLoader: true,
      headerWithToken: true,
      handleError: false,
    );
  }

  Future<dynamic> checkOut(Map<String, dynamic> body) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.checkOut,
      body: body,
      showLoader: true,
      headerWithToken: true,
      handleError: false,
    );
  }
}
