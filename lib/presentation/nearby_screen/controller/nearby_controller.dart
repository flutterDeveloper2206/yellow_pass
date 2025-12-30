import 'package:get/get.dart';

class CafeModel {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final int reviews;
  final bool isFeatured;
  final String distance;

  CafeModel({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.isFeatured,
    required this.distance,
  });
}

class CoWorkerModel {
  final String name;
  final String role;
  final String imageUrl;
  final bool isConnected;

  CoWorkerModel({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.isConnected,
  });
}

class NearbyController extends GetxController {
  final RxList<CafeModel> nearbyCafes = <CafeModel>[
    CafeModel(
      name: 'Chai Point',
      location: 'Raiya Road, Rajkot',
      imageUrl: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400',
      rating: 4.5,
      reviews: 120,
      isFeatured: true,
      distance: '0.5 km',
    ),
    CafeModel(
      name: 'Tea Post',
      location: 'Kalavad Road, Rajkot',
      imageUrl: 'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?w=400',
      rating: 4.7,
      reviews: 95,
      isFeatured: false,
      distance: '1.2 km',
    ),
    CafeModel(
      name: 'Third Wave Coffee',
      location: 'Amin Marg, Rajkot',
      imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400',
      rating: 4.3,
      reviews: 78,
      isFeatured: true,
      distance: '2.1 km',
    ),
    CafeModel(
      name: 'Blue Tokai Coffee',
      location: '150 Feet Ring Road, Rajkot',
      imageUrl: 'https://images.unsplash.com/photo-1521017432531-fbd92d768814?w=400',
      rating: 4.6,
      reviews: 150,
      isFeatured: false,
      distance: '3.5 km',
    ),
  ].obs;

  final RxList<CoWorkerModel> nearbyCoWorkers = <CoWorkerModel>[
    CoWorkerModel(
      name: 'Aman Gupta',
      role: 'CMO, boAt',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlYJkgppWXAfTpt5Ytk4tNSzBWGjDdw_eonA&s',
      isConnected: false,
    ),
    CoWorkerModel(
      name: 'Vinita Singh',
      role: 'CEO, Sugar Cosmetics',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Kw8bl5zLxsFWnN_lOv5frCbiUNASLQ3XbQ&s',
      isConnected: false,
    ),
    CoWorkerModel(
      name: 'Ashneer Grover',
      role: 'Founder, BharatPe',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzaf7NUWEsK1QlVbuCdKXQ4fmjZf_5SFHtWw&s',
      isConnected: false,
    ),
    CoWorkerModel(
      name: 'Namita Thapar',
      role: 'ED, Emcure',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4H-bjvsTb68RvUpzfrehUAAanDONRHwem0Q&s',
      isConnected: true,
    ),
  ].obs;

  void toggleConnection(int index) {
    nearbyCoWorkers[index] = CoWorkerModel(
      name: nearbyCoWorkers[index].name,
      role: nearbyCoWorkers[index].role,
      imageUrl: nearbyCoWorkers[index].imageUrl,
      isConnected: !nearbyCoWorkers[index].isConnected,
    );
    nearbyCoWorkers.refresh();
  }
}
