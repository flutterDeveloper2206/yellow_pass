import 'package:get/get.dart';
import '../../../ApiServices/api_service.dart';
import '../../../ApiServices/api_end_points.dart';
import '../../../data/models/meeting_request_response_model.dart';
import '../../../data/models/nearby_users_response_model.dart';
import '../../../widgets/common_snackbar.dart';

class OtherProfileController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final RxBool isLoading = false.obs;
  late NearbyUser user;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is NearbyUser) {
      user = Get.arguments;
    } else {
      // Fallback or handle null case gracefully
      user = NearbyUser(name: "Unknown User", description: "Co-worker");
    }
  }

  Future<void> requestMeeting(int? userId, String message) async {
    if (userId == null) return;

    isLoading.value = true;

    try {
      final response = await _apiService.callPostApi(
        url: ApiEndPoints.meetingRequests,
        body: {
          "receiver_id": userId,
          "message": message,
        },
      );

      if (response != null) {
        final meetingResponse = MeetingRequestResponseModel.fromJson(response);
        if (meetingResponse.status == true) {
          Get.back(); // Close bottom sheet
          CommonSnackbar.showSuccess(
            message:
                meetingResponse.message ?? "Meeting request sent successfully",
          );
        } else {
          CommonSnackbar.showError(
              message: meetingResponse.message ?? "Something went wrong");
        }
      }
    } catch (e) {
      CommonSnackbar.showError(
          message: "Failed to send request. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
