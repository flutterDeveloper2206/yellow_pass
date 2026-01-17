import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/search_screen/controller/search_controller.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/widgets/shimmer_widget.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, isDark, textColor),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _buildShimmerList(isDark, cardColor);
                }

                if (!controller.isSearching.value) {
                  return _buildInitialState(isDark, subTextColor);
                }

                if (controller.searchResults.isEmpty) {
                  return _buildEmptyState(isDark, subTextColor);
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final cafe = controller.searchResults[index];
                    return _buildSearchResultItem(context, cafe, isDark, textColor, subTextColor, cardColor);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 45,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: controller.onSearchChanged,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration:  InputDecoration(
                        hintText: "Search cafe, co-workers...",
                        hintStyle: TextStyle(color: textColor.withOpacity(0.8)),

                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Obx(() => controller.updateSearchQuery.value.isNotEmpty
                      ? GestureDetector(
                          onTap: controller.clearSearch,
                          child: Icon(Icons.close, color: Colors.grey, size: 20),
                        )
                      : const SizedBox.shrink()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(BuildContext context, Cafe cafe, bool isDark, Color textColor, Color subTextColor, Color cardColor) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.cafeDetailsScreenRoute, arguments: cafe),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.3)],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.darken,
                    child: CustomImageView(
                      url: (cafe.photos != null && cafe.photos!.isNotEmpty)
                          ? "https://api.yellowpass.in${cafe.photos![0]}"
                          : "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                     decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.9),
                       borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black.withOpacity(0.1),
                           blurRadius: 8,
                           offset: const Offset(0, 2),
                         ),
                       ],
                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                         const SizedBox(width: 4),
                         Text(
                           cafe.rating ?? "New",
                           style: PMT.style(12, fontColor: Colors.black, fontWeight: FontWeight.bold),
                         ),
                       ],
                     ),
                   ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                      // backdropFilter: null, // Removed BackdropFilter for performance in lists
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.chair_alt_rounded, color: Colors.white, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          "${cafe.totalSeats ?? 0} Seats Available",
                          style: PMT.style(12, fontColor: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cafe.name ?? "Unknown Cafe",
                              style: PMT.style(20, fontColor: textColor, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, color: subTextColor, size: 16),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${cafe.address}, ${cafe.city}",
                                    style: PMT.style(13, fontColor: subTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                           "\$${cafe.pricePerHour ?? '15'}/hr",
                           style: PMT.style(16, fontColor: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildMiniChip("Wifi", Icons.wifi, isDark, subTextColor),
                            if (cafe.amenities != null && cafe.amenities!.contains("Coffee"))
                               _buildMiniChip("Coffee", Icons.coffee, isDark, subTextColor)
                            else 
                               _buildMiniChip("Power", Icons.bolt, isDark, subTextColor),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white : Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: isDark ? Colors.black : Colors.white,
                          size: 18,
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

  Widget _buildMiniChip(String label, IconData icon, bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: PMT.style(11, fontColor: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList(bool isDark, Color cardColor) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerWidget.rectangular(height: 180, width: double.infinity),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: const [
                          ShimmerWidget.rectangular(height: 20, width: 150),
                          ShimmerWidget.rectangular(height: 20, width: 60),
                       ],
                    ),
                    const SizedBox(height: 10),
                    const ShimmerWidget.rectangular(height: 14, width: 200),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        ShimmerWidget.rectangular(height: 25, width: 80),
                        SizedBox(width: 8),
                        ShimmerWidget.rectangular(height: 25, width: 80),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInitialState(bool isDark, Color subTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search_rounded, size: 50, color: subTextColor),
          ),
          const SizedBox(height: 20),
          Text(
            "Find Your Perfect Workspace",
            style: PMT.style(18, fontColor: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Search for cafes, coworking spaces,\nand more near you.",
            textAlign: TextAlign.center,
            style: PMT.style(14, fontColor: subTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark, Color subTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2C2C2C) : Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search_off_rounded, size: 50, color: Colors.red.shade300),
          ),
          const SizedBox(height: 20),
          Text(
            "No Results Found",
            style: PMT.style(18, fontColor: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "We couldn't find any cafes matching\nyour search. Try different keywords.",
            textAlign: TextAlign.center,
            style: PMT.style(14, fontColor: subTextColor),
          ),
        ],
      ),
    );
  }
}
