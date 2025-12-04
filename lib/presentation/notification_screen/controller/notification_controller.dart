import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[
    {
      "type": "reminder",
      "title": "Reminder",
      "description": "You have booked Cafe Aarosh today at 12:00. Don't forget to be there on time",
      "isUnread": true,
    },
    {
      "type": "reminder",
      "title": "Reminder",
      "description": "You have to check-out at Cafe Aarosh in coming 15 mins.",
      "isUnread": true,
    },
    {
      "type": "connection",
      "title": "Connection",
      "description": "New connection. Amaliya has accepted your connection request.",
      "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop",
      "isUnread": true,
    },
    {
      "type": "reminder",
      "title": "Booking Confirmed",
      "description": "Your booking at Cafe Coffee Day is confirmed for tomorrow.",
      "isUnread": false,
    },
    {
      "type": "connection",
      "title": "Connection",
      "description": "John Doe sent you a connection request.",
      "image": "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1887&auto=format&fit=crop",
      "isUnread": false,
    },
  ].obs;
}
