import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/widgets/bouncing_button.dart';
import 'package:yellow_pass/presentation/cafe_details_screen/controller/cafe_details_controller.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ApiServices/api_end_points.dart';
import '../../core/utils/color_constant.dart';

class CafeDetailsScreen extends GetView<CafeDetailsController> {
  const CafeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,
      body: Obx(() {
        if (controller.isLoading.value && controller.cafe.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.cafe.value == null) {
          return const Center(child: Text("Cafe not found"));
        }

        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                _buildAppBar(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCafeInfo(context),
                        const SizedBox(height: 20),
                        _buildFeatures(context),
                        const SizedBox(height: 20),
                        _buildTables(context),
                        const SizedBox(height: 20),
                        if (controller.cafeDiscount.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "${controller.cafeDiscount} on all coffee orders when you book through Yellow Space.",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        _buildTimings(context),
                        const SizedBox(height: 20),
                        _buildLocationMap(context),
                        const SizedBox(height: 20),
                        _buildReviews(context),
                        const SizedBox(height: 100), // Space for bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: _buildBottomButton(context),
            ),
            if (controller.isLoading.value)
              const Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: const Text("Back", style: TextStyle(color: Colors.white)),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              itemCount: controller.images.length,
              onPageChanged: controller.updateImageIndex,
              itemBuilder: (context, index) {
                return CustomImageView(
                  url: controller.images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.images.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentImageIndex.value == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  )),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor, // Yellow color
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  controller.cafeTokens,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                controller.cafeSeats,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCafeInfo(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.cafeName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star,
                    color: ColorConstant.primaryColor, size: 20),
                const SizedBox(width: 4),
                Text(
                  controller.cafeRating,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on,
                size: 16,
                color:
                    isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                controller.cafeLocation,
                style: TextStyle(
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          controller.cafeDescription,
          style: TextStyle(
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Address: ${controller.cafeLocation}",
          style: TextStyle(
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTimings(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cafe = controller.cafe.value;

    if (cafe?.timings == null || cafe!.timings!.isEmpty)
      return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Opening Hours",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color:
                    isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          ),
          child: Column(
            children: cafe.timings!.map((timing) {
              final parts = timing.split(' (');
              final day = parts[0];
              final time = parts.length > 1 ? parts[1].replaceAll(')', '') : '';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        color: isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color:
                            isDarkMode ? Colors.green : Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationMap(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final coords = controller.mapCoordinates;
      if (coords == null) return const SizedBox.shrink();

      final (lat, lng) = coords;
      final target = LatLng(lat, lng);
      final cafeMarkers = <Marker>{
        Marker(
          markerId: const MarkerId('cafe_preview'),
          position: target,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          infoWindow: InfoWindow(title: controller.cafeName),
        ),
      };

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _openFullScreenCafeMap(
              context,
              latitude: lat,
              longitude: lng,
              isDarkMode: isDarkMode,
              cafeName: controller.cafeName,
            ),
            behavior: HitTestBehavior.opaque,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: IgnorePointer(
                        child: GoogleMap(
                          key: ValueKey('cafe_map_${lat}_$lng'),
                          initialCameraPosition: CameraPosition(
                            target: target,
                            zoom: 16,
                          ),
                          markers: cafeMarkers,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          myLocationButtonEnabled: false,
                          compassEnabled: false,
                          liteModeEnabled: false,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.fullscreen,
                                color: Colors.white, size: 18),
                            SizedBox(width: 4),
                            Text(
                              'Tap',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildReviews(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final reviews = controller.cafeReviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            if (reviews.isNotEmpty)
              Text(
                "${reviews.length} total",
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (reviews.isEmpty)
          Text(
            "No reviews yet.",
            style: TextStyle(
                color:
                    isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: review.user?.profilePicture != null
                              ? NetworkImage(review.user!.profilePicture!)
                              : null,
                          child: review.user?.profilePicture == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.user?.name ?? "Anonymous",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              Row(
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    Icons.star,
                                    size: 14,
                                    color: starIndex < (review.rating ?? 0)
                                        ? ColorConstant.primaryColor
                                        : Colors.grey.shade400,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          review.createdAt?.split('T')[0] ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode
                                ? Colors.grey.shade500
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review.reviewText ?? "",
                      style: TextStyle(
                        color: isDarkMode
                            ? Colors.grey.shade300
                            : Colors.grey.shade800,
                        fontSize: 14,
                      ),
                    ),
                    if (review.photos != null && review.photos!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: review.photos!.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomImageView(
                                url:
                                    "${ApiEndPoints.imageBaseUrl}${review.photos![index]}",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final theme = Theme.of(context);
    final amenities = controller.cafe.value?.amenities ?? [];

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (amenities.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amenities",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color:
                    isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 16,
            children: amenities.map((amenity) {
              IconData icon;
              String label = amenity;

              if (amenity.toLowerCase().contains("wifi")) {
                icon = Icons.wifi;
              } else if (amenity.toLowerCase().contains("coffee")) {
                icon = Icons.coffee;
              } else if (amenity.toLowerCase().contains("parking")) {
                icon = Icons.local_parking;
              } else if (amenity.toLowerCase().contains("power")) {
                icon = Icons.power;
              } else {
                icon = Icons.star_outline;
              }

              return _buildFeatureItem(context, icon, label);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String label) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        CircleAvatar(
          backgroundColor:
              isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          radius: 18,
          child: Icon(icon,
              size: 18,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildTables(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final tables = controller.cafe.value?.tables ?? [];

    if (tables.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Tables",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tables.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final table = tables[index];
              return Container(
                width: 120,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade200),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      table.capacity! > 4
                          ? Icons.groups
                          : (table.capacity! > 1 ? Icons.group : Icons.person),
                      color: ColorConstant.primaryColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      (table.name == null || table.name!.isEmpty)
                          ? "Standard Table"
                          : table.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${table.capacity} Person",
                      style: TextStyle(
                        color: isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final accentColor = ColorConstant.primaryColor;
    final secondaryBtnColor =
        isDarkMode ? const Color(0xFF2C2C2C) : Colors.grey.shade100;

    return Row(
      children: [
        Expanded(
          child: Bounce(
            onTap: () {
              if (controller.cafe.value != null) {
                Get.toNamed(AppRoutes.menuScreenRoute,
                    arguments: controller.cafe.value);
              }
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: secondaryBtnColor,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Menu",
                  style: PMT.style(16,
                      fontColor: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Bounce(
            onTap: () {
              if (controller.cafe.value != null) {
                Get.toNamed(AppRoutes.cafeBookScreenRoute,
                    arguments: controller.cafe.value);
              }
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Book Now",
                  style: PMT.style(16,
                      fontColor: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openFullScreenCafeMap(
    BuildContext context, {
    required double latitude,
    required double longitude,
    required bool isDarkMode,
    required String cafeName,
  }) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => _CafeFullScreenGoogleMapPage(
          latitude: latitude,
          longitude: longitude,
          isDarkMode: isDarkMode,
          cafeName: cafeName,
        ),
      ),
    );
  }
}

Future<void> _launchCafeInExternalGoogleMaps(double lat, double lng) async {
  final uri = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _CafeFullScreenGoogleMapPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final bool isDarkMode;
  final String cafeName;

  const _CafeFullScreenGoogleMapPage({
    required this.latitude,
    required this.longitude,
    required this.isDarkMode,
    required this.cafeName,
  });

  @override
  Widget build(BuildContext context) {
    final target = LatLng(latitude, longitude);
    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('cafe_fullscreen'),
        position: target,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(title: cafeName),
      ),
    };

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          cafeName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            key: ValueKey('cafe_map_fs_${latitude}_$longitude'),
            initialCameraPosition: CameraPosition(
              target: target,
              zoom: 17,
            ),
            markers: markers,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: true,
            zoomControlsEnabled: true,
            compassEnabled: true,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () =>
                        _launchCafeInExternalGoogleMaps(latitude, longitude),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text(
                      'Open in Google Maps',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
