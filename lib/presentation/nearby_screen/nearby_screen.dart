import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/widgets/shimmer_widget.dart';
import '../../../data/models/cafe_response_model.dart';
import '../../../data/models/nearby_users_response_model.dart';
import 'controller/nearby_controller.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  late NearbyController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NearbyController());
    controller.fetchAllNearbyData();
    controller.nearbyCafes.clear();
    controller.nearbyCoWorkers.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text(
          "Nearby",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchAllNearbyData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nearby Yellow Spaces Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FadeInDown(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    "Nearby Yellow Spaces",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (controller.isLoadingCafes.value && controller.nearbyCafes.isEmpty) {
                  return _buildCafeShimmer();
                }

                if (controller.nearbyCafes.isEmpty) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        "No nearby spaces found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.nearbyCafes.length,
                    itemBuilder: (context, index) {
                      return FadeInRight(
                        duration: const Duration(milliseconds: 400),
                        delay: Duration(milliseconds: 100 * index),
                        child: _buildCafeCard(context, controller.nearbyCafes[index]),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 24),
              // Nearby Co-workers Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    "Nearby Co-workers",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (controller.isLoadingCoWorkers.value ) {
                  return _buildCoWorkerShimmer();
                }

                if (!controller.isLoadingCoWorkers.value&&controller.nearbyCoWorkers.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "No nearby co-workers found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 12,
                    children: List.generate(
                      controller.nearbyCoWorkers.length,
                      (index) => FadeInUp(
                        duration: const Duration(milliseconds: 400),
                        delay: Duration(milliseconds: 100 * index),
                        child: _buildCoWorkerCard(context, controller.nearbyCoWorkers[index], index),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCafeShimmer() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return Container(
            width: 220,
            margin: const EdgeInsets.only(right: 16, bottom: 10),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: ShimmerWidget.rectangular(height: 140, width: 220),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerWidget.rectangular(height: 16, width: 150),
                      SizedBox(height: 8),
                      ShimmerWidget.rectangular(height: 12, width: 100),
                      SizedBox(height: 12),
                      ShimmerWidget.rectangular(height: 14, width: 60),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoWorkerShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        spacing: 0,
        runSpacing: 12,
        children: List.generate(
          4,
          (index) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;
            return Container(
              width: (MediaQuery.of(context).size.width - 48) / 2,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  ShimmerWidget.circular(width: 80, height: 80),
                  SizedBox(height: 12),
                  ShimmerWidget.rectangular(height: 16, width: 100),
                  SizedBox(height: 8),
                  ShimmerWidget.rectangular(height: 12, width: 80),
                  SizedBox(height: 12),
                  ShimmerWidget.rectangular(height: 14, width: 60),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCafeCard(BuildContext context, Cafe cafe) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final imageUrl = (cafe.photos != null && cafe.photos!.isNotEmpty)
        ? cafe.photos![0]
        : "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400";

    // Prepend base url if it's a relative path
    final fullImageUrl = imageUrl.startsWith("http") 
        ? imageUrl 
        : "https://api.yellowpass.in$imageUrl";

    return GestureDetector(
      onTap: () => Get.toNamed('/cafe_details_screen', arguments: cafe.id),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16, bottom: 10),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isDarkMode)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CustomImageView(
                    url: fullImageUrl,
                    height: 140,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      cafe.category ?? "Cafe",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cafe.name ?? "Unknown",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          cafe.address ?? cafe.city ?? "Location unknown",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text(
                            cafe.rating ?? '0.0',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${cafe.reviewCount ?? 0})',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      if (cafe.pricePerHour != null)
                        Text(
                          "₹${cafe.pricePerHour}/hr",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoWorkerCard(BuildContext context, NearbyUser coWorker, int index) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final profilePic = coWorker.profilePicture ?? "https://api.yellowpass.in/storage/profile-pictures/default.png";
    final fullProfilePic = profilePic.startsWith("http") 
        ? profilePic 
        : "https://api.yellowpass.in$profilePic";

    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.yellow.withOpacity(0.2),
            backgroundImage: NetworkImage(fullProfilePic),
          ),
          const SizedBox(height: 12),
          // Name
          Text(
            coWorker.name ?? "Anonymous",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Description / Role
          Text(
            coWorker.description ?? "Co-worker",
            style: TextStyle(
              fontSize: 11,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Distance
          if (coWorker.distance != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "${coWorker.distance!.toStringAsFixed(1)} km away",
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
