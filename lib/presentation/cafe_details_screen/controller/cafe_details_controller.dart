import 'package:get/get.dart';

class CafeDetailsController extends GetxController {
  // Cafe data received from arguments
  late Map<String, dynamic> cafeData;
  
  RxList<String> images = <String>[].obs;
  RxInt currentImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the cafe data passed from home screen
    cafeData = Get.arguments ?? {};
    
    // Set images from cafe data
    if (cafeData['images'] != null && cafeData['images'] is List) {
      images.value = List<String>.from(cafeData['images']);
    } else if (cafeData['image'] != null) {
      // Fallback to single image if images array not available
      images.value = [cafeData['image']];
    } else {
      // Default images if no data
      images.value = [
        'https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop',
      ];
    }
  }

  void updateImageIndex(int index) {
    currentImageIndex.value = index;
  }

  // Get cafe name
  String get cafeName => cafeData['name'] ?? 'Cafe Aarosh';
  
  // Get cafe location
  String get cafeLocation => cafeData['location'] ?? 'Sadashiv Peth, Pune';
  
  // Get cafe rating
  String get cafeRating => cafeData['rating'] ?? '4.7/5';
  
  // Get cafe description
  String get cafeDescription => cafeData['description'] ?? 'This cafe provides a cozy and pet-friendly space along with free wi-fi, you can also get beverages on 10% Off.';
  
  // Get cafe timings
  String get cafeTimings => cafeData['timings'] ?? '11:00am- 09:00pm';
  
  // Get cafe discount
  String get cafeDiscount => cafeData['discount'] ?? '10% OFF';
  
  // Get cafe seats
  String get cafeSeats => cafeData['seats'] ?? '4 Seats Available';
  
  // Get cafe tokens
  String get cafeTokens => cafeData['tokens'] ?? '150 Yellow Tokens/hr';

  final List<String> dates = ['11', '12', '13', '14', '15'];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final List<String> timeSlots = ['11:00 am', '12:45 pm', '3:00 pm', '6:15 pm'];
  final List<String> tableSizes = ['Table of 2', 'Table of 4', 'Meeting Room'];
}
