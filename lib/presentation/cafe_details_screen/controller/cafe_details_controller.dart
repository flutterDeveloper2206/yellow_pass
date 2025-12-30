import 'package:get/get.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';
import 'package:yellow_pass/data/models/cafe_details_response_model.dart';
import '../repository/cafe_details_repository.dart';

class CafeDetailsController extends GetxController {
  final CafeDetailsRepository _repository = Get.find<CafeDetailsRepository>();
  
  // Cafe data received from arguments or API
  Rx<Cafe?> cafe = Rx<Cafe?>(null);
  RxBool isLoading = false.obs;
  
  RxList<String> images = <String>[].obs;
  RxInt currentImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the cafe data passed from home screen
    if (Get.arguments is Cafe) {
      cafe.value = Get.arguments;
      _updateImages();
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Fetch fresh details for tables/reviews
    if (cafe.value?.id != null) {
      fetchCafeDetails(cafe.value!.id!);
    } else if (Get.arguments is String) {
      // If only ID is passed
      fetchCafeDetails(Get.arguments);
    }
  }

  Future<void> fetchCafeDetails(String id) async {
    isLoading.value = true;
    try {
      var response = await _repository.getCafeDetails(id);
      if (response != null && response['status'] == true) {
        CafeDetailsResponse cafeDetailsResponse = CafeDetailsResponse.fromJson(response);
        if (cafeDetailsResponse.data != null) {
          cafe.value = cafeDetailsResponse.data;
          _updateImages();
        }
      }
    } catch (e) {
      print("Error fetching cafe details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _updateImages() {
    if (cafe.value?.photos != null && cafe.value!.photos!.isNotEmpty) {
      images.value = cafe.value!.photos!.map((e) => "https://api.yellowpass.in$e").toList();
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
  String get cafeName => cafe.value?.name ?? 'Cafe Name';
  
  // Get cafe location
  String get cafeLocation => (cafe.value?.address != null && cafe.value?.city != null) 
      ? "${cafe.value!.address}, ${cafe.value!.city}" 
      : (cafe.value?.address ?? cafe.value?.city ?? 'Location');
  
  // Get cafe rating
  String get cafeRating => (cafe.value?.averageRating != null) 
      ? "${cafe.value!.averageRating} (${cafe.value!.totalReviews ?? 0})" 
      : (cafe.value?.rating ?? '0.0');
  
  // Get cafe description
  String get cafeDescription => cafe.value?.description ?? 'No description available.';
  
  // Get cafe timings
  String get cafeTimings {
    if (cafe.value?.timings != null && cafe.value!.timings!.isNotEmpty) {
      return cafe.value!.timings!.join("\n");
    }
    return (cafe.value?.openTime != null && cafe.value?.closeTime != null)
        ? "${cafe.value!.openTime} - ${cafe.value!.closeTime}"
        : 'Timings not set';
  }
  
  // Get cafe discount (not yet in API)
  String get cafeDiscount => '';
  
  // Get cafe seats
  String get cafeSeats => "${cafe.value?.totalSeats ?? 0} Seats Available";
  
  // Get cafe tokens
  String get cafeTokens => "${cafe.value?.pricePerHour ?? '0'} Yellow Tokens/hr";

  List<Review> get cafeReviews => cafe.value?.reviews ?? [];

  List<String> get tableSizes {
    if (cafe.value?.tables != null && cafe.value!.tables!.isNotEmpty) {
      return cafe.value!.tables!
          .where((t) => t.name != null)
          .map((t) => "${t.name} (${t.capacity} Person)").toList();
    }
    return [];
  }
}
