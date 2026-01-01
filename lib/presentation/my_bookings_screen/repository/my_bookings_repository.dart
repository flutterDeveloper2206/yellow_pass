import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class MyBookingsRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getUserBookings() async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.userBookings,
      showLoader: false,
      headerWithToken: true,
    );
  }

  Future<dynamic> cancelBooking(String bookingId) async {
    final url = "${ApiEndPoints.bookings}/$bookingId/cancel";
    return await _apiService.callPostApi(
      url: url,
      body: {},
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> submitReview({
    required Map<String, String> fields,
    required List<Map<String, String>> files,
  }) async {
    return await _apiService.uploadMultipart(
      url: ApiEndPoints.reviews,
      fields: fields,
      files: files,
      showLoader: true,
      headerWithToken: true,
    );
  }
}
