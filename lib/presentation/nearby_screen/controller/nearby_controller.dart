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
      name: 'Cafe Aarosh',
      location: 'Sadashiv Peth, Pune',
      imageUrl: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400',
      rating: 4.5,
      reviews: 120,
      isFeatured: true,
      distance: '0.5 km',
    ),
    CafeModel(
      name: 'Cafe Aarosh',
      location: 'Koregaon Park, Pune',
      imageUrl: 'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?w=400',
      rating: 4.7,
      reviews: 95,
      isFeatured: false,
      distance: '1.2 km',
    ),
    CafeModel(
      name: 'The Coffee House',
      location: 'FC Road, Pune',
      imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400',
      rating: 4.3,
      reviews: 78,
      isFeatured: true,
      distance: '2.1 km',
    ),
    CafeModel(
      name: 'Urban Cafe',
      location: 'Baner, Pune',
      imageUrl: 'https://images.unsplash.com/photo-1521017432531-fbd92d768814?w=400',
      rating: 4.6,
      reviews: 150,
      isFeatured: false,
      distance: '3.5 km',
    ),
  ].obs;

  final RxList<CoWorkerModel> nearbyCoWorkers = <CoWorkerModel>[
    CoWorkerModel(
      name: 'Ninad U',
      role: 'UI/UX Designer',
      imageUrl: 'https://i.pravatar.cc/150?img=1',
      isConnected: false,
    ),
    CoWorkerModel(
      name: 'Mike Jr',
      role: 'UI/UX Designer',
      imageUrl: 'https://i.pravatar.cc/150?img=2',
      isConnected: false,
    ),
    CoWorkerModel(
      name: 'Niha',
      role: 'UI/UX Designer',
      imageUrl: 'https://i.pravatar.cc/150?img=3',
      isConnected: false,
    ),
    CoWorkerModel(
      name: 'Sarah K',
      role: 'Product Manager',
      imageUrl: 'https://i.pravatar.cc/150?img=4',
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
