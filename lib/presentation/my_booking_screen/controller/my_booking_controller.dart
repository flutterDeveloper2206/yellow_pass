import 'package:get/get.dart';

class MyBookingController extends GetxController {
  RxBool isCheckedIn = false.obs;
  
  final List<Map<String, dynamic>> menuItems = [
    {
      "name": "Cappuccino",
      "price": "150 Tokens",
      "image": "https://images.unsplash.com/photo-1572442388796-11668a67e53d?q=80&w=3535&auto=format&fit=crop",
    },
    {
      "name": "Croissant",
      "price": "120 Tokens",
      "image": "https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=3326&auto=format&fit=crop",
    },
    {
      "name": "Blueberry Muffin",
      "price": "100 Tokens",
      "image": "https://images.unsplash.com/photo-1607958996333-41aef7caefaa?q=80&w=3387&auto=format&fit=crop",
    },
     {
      "name": "Iced Latte",
      "price": "160 Tokens",
      "image": "https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?q=80&w=3387&auto=format&fit=crop",
    },
  ];

  void checkIn() {
    // Logic to handle check-in (e.g., navigate to scanner)
    Get.toNamed('/qr_scanner_screen');
  }

  void checkOut() {
    isCheckedIn.value = false;
    Get.snackbar("Success", "Checked out successfully");
  }
  
  void setCheckedIn() {
      isCheckedIn.value = true;
  }
}
