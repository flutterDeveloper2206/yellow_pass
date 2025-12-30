import 'package:get/get.dart';
import 'package:yellow_pass/data/models/notification_response_model.dart';
import '../repository/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository = Get.find<NotificationRepository>();
  
  RxList<NotificationData> notifications = <NotificationData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      var response = await _repository.getNotifications();
      if (response != null && response['status'] == true) {
        NotificationResponse notificationResponse = NotificationResponse.fromJson(response);
        if (notificationResponse.data != null) {
          notifications.value = notificationResponse.data!;
        }
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Group notifications by type
  Map<String, List<NotificationData>> get groupedNotifications {
    Map<String, List<NotificationData>> grouped = {};
    for (var notification in notifications) {
      String type = notification.type ?? 'other';
      if (!grouped.containsKey(type)) {
        grouped[type] = [];
      }
      grouped[type]!.add(notification);
    }
    return grouped;
  }
}
