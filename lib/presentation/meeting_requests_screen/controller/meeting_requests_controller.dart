import 'package:get/get.dart';
import '../../../ApiServices/api_service.dart';
import '../../../ApiServices/api_end_points.dart';
import '../../../data/models/meeting_list_response_model.dart';
import '../../../widgets/common_snackbar.dart';

class MeetingRequestsController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final RxList<MeetingRequest> incomingRequests = <MeetingRequest>[].obs;
  final RxList<MeetingRequest> sentRequests = <MeetingRequest>[].obs;

  final RxBool isLoadingIncoming = false.obs;
  final RxBool isLoadingSent = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  void fetchRequests() {
    fetchIncomingRequests();
    fetchSentRequests();
  }

  Future<void> fetchIncomingRequests() async {
    isLoadingIncoming.value = true;
    try {
      final response = await _apiService.callGetApi(
          url: ApiEndPoints.incomingMeetingRequests);
      if (response != null) {
        final model = MeetingListResponseModel.fromJson(response);
        if (model.status == true) {
          incomingRequests.value = model.data ?? [];
        }
      }
    } catch (e) {
      print("Error fetching incoming requests: $e");
    } finally {
      isLoadingIncoming.value = false;
    }
  }

  Future<void> fetchSentRequests() async {
    isLoadingSent.value = true;
    try {
      final response =
          await _apiService.callGetApi(url: ApiEndPoints.sentMeetingRequests);
      if (response != null) {
        final model = MeetingListResponseModel.fromJson(response);
        if (model.status == true) {
          sentRequests.value = model.data ?? [];
        }
      }
    } catch (e) {
      print("Error fetching sent requests: $e");
    } finally {
      isLoadingSent.value = false;
    }
  }

  Future<void> respondToRequest(
      int id, String status, String responseMessage) async {
    try {
      final response = await _apiService.callPostApi(
        url: ApiEndPoints.respondMeetingRequest(id.toString()),
        body: {
          "status": status,
          "response_message": responseMessage,
        },
      );

      if (response != null) {
        if (response['status'] == true) {
          CommonSnackbar.showSuccess(
              message: response['message'] ?? "Action completed successfully");
          fetchIncomingRequests();
        } else {
          CommonSnackbar.showError(
              message: response['message'] ?? "Something went wrong");
        }
      }
    } catch (e) {
      CommonSnackbar.showError(message: "Failed to respond. Please try again.");
    }
  }
}
