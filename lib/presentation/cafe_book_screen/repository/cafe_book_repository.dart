import 'package:get/get.dart';
import '../../../../ApiServices/api_end_points.dart';
import '../../../../ApiServices/api_service.dart';

class CafeBookRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> getTableTypes(String cafeId) async {
    return await _apiService.callGetApi(
      url: ApiEndPoints.tableTypes(cafeId),
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> checkAvailability({
    required String cafeId,
    required String tableTypeId,
    required String date,
    required int duration,
  }) async {
    final url = "${ApiEndPoints.checkAvailability}?cafe_id=$cafeId&table_type_id=$tableTypeId&date=$date&duration_hours=$duration";
    return await _apiService.callGetApi(
      url: url,
      showLoader: true,
      headerWithToken: true,
    );
  }

  Future<dynamic> bookCafe(Map<String, dynamic> bookingData) async {
    return await _apiService.callPostApi(
      url: ApiEndPoints.bookings,
      body: bookingData,
      showLoader: true,
      headerWithToken: true,
    );
  }
}
