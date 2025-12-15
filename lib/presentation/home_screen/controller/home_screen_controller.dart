

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

  final List<Map<String, dynamic>> featuredCafes = [
    {
      "id": "1",
      "name": "Cafe Aarosh",
      "location": "Rajkot",
      "rating": "4.7/5",
      "discount": "10% OFF",
      "seats": "4 Seats Available",
      "tokens": "150 Yellow Tokens/hr",
      "description": "This cafe provides a cozy and pet-friendly space along with free wi-fi, you can also get beverages on 10% Off.",
      "timings": "11:00am- 09:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "10% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
      "isFeatured": true,
    },
    {
      "id": "2",
      "name": "The Coffee House",
      "location": "Koregaon Park, Pune",
      "rating": "4.5/5",
      "discount": "15% OFF",
      "seats": "6 Seats Available",
      "tokens": "120 Yellow Tokens/hr",
      "description": "Modern coffee house with excellent ambiance and high-speed internet. Perfect for remote work and meetings.",
      "timings": "10:00am- 10:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "15% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
      "isFeatured": true,
    },
    {
      "id": "3",
      "name": "Rooftop Cafe",
      "location": "Baner, Pune",
      "rating": "4.8/5",
      "discount": "20% OFF",
      "seats": "8 Seats Available",
      "tokens": "180 Yellow Tokens/hr",
      "description": "Beautiful rooftop cafe with stunning city views. Ideal for evening hangouts and casual meetings.",
      "timings": "12:00pm- 11:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "20% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
      "isFeatured": true,
    },
    {
      "id": "4",
      "name": "Green Garden Cafe",
      "location": "Viman Nagar, Pune",
      "rating": "4.6/5",
      "discount": "12% OFF",
      "seats": "5 Seats Available",
      "tokens": "140 Yellow Tokens/hr",
      "description": "Surrounded by greenery, this cafe offers a peaceful environment for work and relaxation.",
      "timings": "09:00am- 08:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "12% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
      "isFeatured": true,
    },
    {
      "id": "5",
      "name": "Urban Workspace",
      "location": "Hinjewadi, Pune",
      "rating": "4.9/5",
      "discount": "25% OFF",
      "seats": "10 Seats Available",
      "tokens": "200 Yellow Tokens/hr",
      "description": "Premium co-working cafe with dedicated workstations and meeting rooms. Best for professionals.",
      "timings": "08:00am- 10:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "25% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
      "isFeatured": true,
    },
  ];

  final List<Map<String, dynamic>> recommendedCafes = [
    {
      "id": "6",
      "name": "Sunset Lounge",
      "location": "Kalyani Nagar, Pune",
      "rating": "4.4/5",
      "discount": "10% OFF",
      "seats": "3 Seats Available",
      "tokens": "130 Yellow Tokens/hr",
      "description": "Cozy lounge with comfortable seating and great coffee. Perfect for casual work sessions.",
      "timings": "11:00am- 09:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "10% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "id": "7",
      "name": "Book & Brew",
      "location": "FC Road, Pune",
      "rating": "4.7/5",
      "discount": "15% OFF",
      "seats": "7 Seats Available",
      "tokens": "160 Yellow Tokens/hr",
      "description": "A book lover's paradise with great coffee and quiet corners for reading and working.",
      "timings": "10:00am- 10:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "15% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
    },
    {
      "id": "8",
      "name": "Artisan Coffee Co.",
      "location": "Aundh, Pune",
      "rating": "4.5/5",
      "discount": "18% OFF",
      "seats": "4 Seats Available",
      "tokens": "145 Yellow Tokens/hr",
      "description": "Artisanal coffee and fresh pastries in a warm, inviting atmosphere.",
      "timings": "09:00am- 08:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "18% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
    },
    {
      "id": "9",
      "name": "The Study Spot",
      "location": "Kothrud, Pune",
      "rating": "4.3/5",
      "discount": "10% OFF",
      "seats": "6 Seats Available",
      "tokens": "110 Yellow Tokens/hr",
      "description": "Quiet and focused environment perfect for students and professionals.",
      "timings": "08:00am- 09:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "10% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "id": "10",
      "name": "Poolside Paradise",
      "location": "Wakad, Pune",
      "rating": "4.8/5",
      "discount": "22% OFF",
      "seats": "9 Seats Available",
      "tokens": "190 Yellow Tokens/hr",
      "description": "Unique poolside cafe with refreshing vibes and excellent service.",
      "timings": "11:00am- 11:00pm",
      "amenities": ["Wi-Fi", "Power Outlets", "22% OFF"],
      "images": [
        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
      ],
      "image": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
    },
  ];

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.receipt_long_outlined,
    Icons.send_time_extension_outlined,
    Icons.person_2_outlined,
  ];
}
