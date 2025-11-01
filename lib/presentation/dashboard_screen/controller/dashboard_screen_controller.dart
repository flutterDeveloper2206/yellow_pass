import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DashboardScreenController extends GetxController {

  final RxInt currentIndex = 0.obs;
  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.receipt_long_outlined,
    Icons.send_time_extension_outlined,
    Icons.person_2_outlined,
  ];

  // Example pages
  final List<Widget> pages = [
    const Center(child: Text("🏠 Home Page", style: TextStyle(fontSize: 24))),
    const Center(child: Text("❤️ Favorites", style: TextStyle(fontSize: 24))),
    const Center(child: Text("🔍 Search", style: TextStyle(fontSize: 24))),
    const Center(child: Text("👤 Profile", style: TextStyle(fontSize: 24))),
  ];
}
