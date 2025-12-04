

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {


  final RxInt currentIndex = 0.obs;
  final RxInt selectedCategoryIndex = 0.obs;

  final List<String> categories = [
    "Poolside",
    "Pet-Friendly",
    "Pure Veg",
    "Co-working",
    "Rooftop",
  ];

  final List<Map<String, dynamic>> featuredCafes = List.generate(5, (index) => {
    "name": "Cafe Aarosh",
    "location": "Sadashiv Peth, Pune",
    "rating": "5/5",
    "discount": "10% OFF",
    "image": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop", // Replace with local asset if available
    "isFeatured": true,
  });

  final List<Map<String, dynamic>> recommendedCafes = List.generate(5, (index) => {
    "name": "Cafe Aarosh",
    "location": "Sadashiv Peth, Pune",
    "rating": "4.7/5",
    "discount": "10% OFF",
    "seats": "2 Seats Available",
    "description": "This cafe provides a cozy and petfriendly space along with free wi-fi...",
    "amenities": ["Wi-fi", "PetFriendly", "PowerOutrage"],
    "image": "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
  });

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.receipt_long_outlined,
    Icons.send_time_extension_outlined,
    Icons.person_2_outlined,
  ];
}
