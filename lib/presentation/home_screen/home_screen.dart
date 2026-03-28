import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/core/utils/image_constant.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'package:yellow_pass/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/widgets/bouncing_button.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
// import 'package:animate_do/animate_do.dart';
import '../../data/models/cafe_response_model.dart';
import '../../data/models/user_booking_response_model.dart';
import '../../data/models/active_booking_response_model.dart';
import '../../widgets/shimmer_widget.dart';
import '../../ApiServices/api_end_points.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeScreenController controller;
  late AnimationController _animationController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeScreenController());
    controller.loadUserData();
    controller.fetchCategories();
    controller.fetchCafes();
    controller.fetchBannerAds();
    controller.fetchActiveBooking();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final accentColor = ColorConstant.primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildHeader(context, textColor, isDark, accentColor),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSearchBar(context, isDark, textColor),
              ),
              const SizedBox(height: 20),
              Obx(() => controller.activeBooking.value != null
                  ? _buildActiveBookingWidget(
                      context, isDark, textColor, accentColor)
                  : const SizedBox.shrink()),
              const SizedBox(height: 10),

              _buildBannerAds(context, isDark),

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Explore Yellow Spaces",
                  style: PMT.style(18,
                      fontColor: textColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              _buildCategories(context, isDark, accentColor),
              const SizedBox(height: 20),
              _buildRecommendedSection(context, isDark, textColor, subTextColor,
                  cardColor, accentColor),
              const SizedBox(height: 80), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, Color textColor, bool isDark, Color accentColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to profile or open drawer
            Get.toNamed(AppRoutes.profileScreenRoute);
          },
          child: Obx(() => Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: accentColor, width: 2),
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      (controller.userData['profile_picture'] != null &&
                              controller.userData['profile_picture']
                                  .toString()
                                  .isNotEmpty)
                          ? NetworkImage(
                                  "${controller.userData['profile_picture']}")
                              as ImageProvider
                          : const AssetImage('assets/images/profiles.png'),
                ),
              )),
        ),
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: textColor),
            const SizedBox(width: 4),
            Text(
              "Rajkot",
              style: PMT.style(14,
                  fontColor: textColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            Obx(() => CupertinoSwitch(
                  value: controller.isProfileVisible.value,
                  onChanged: (value) => controller.toggleVisibility(value),
                  activeColor: accentColor,
                )),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.notificationScreenRoute);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200,
                ),
                child: Icon(Icons.notifications_outlined,
                    size: 20, color: isDark ? Colors.grey : Colors.black54),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveBookingWidget(
      BuildContext context, bool isDark, Color textColor, Color accentColor) {
    final booking = controller.activeBooking.value!;
    final cafe = booking.cafe;

    String imageUrl = "";
    if (cafe?.photos != null && cafe!.photos!.isNotEmpty) {
      imageUrl = cafe.photos![0].startsWith('/')
          ? "${ApiEndPoints.imageBaseUrl}" + cafe.photos![0]
          : cafe.photos![0];
    } else {
      imageUrl =
          "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=200";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Bounce(
        onTap: () {
          // Map ActiveBooking to UserBookingData for MyBookingScreen
          // We also need to map the Cafe to BookingCafe
          final bookingCafe = cafe != null
              ? BookingCafe(
                  name: cafe.name,
                  address: cafe.address,
                  image: (cafe.photos != null && cafe.photos!.isNotEmpty)
                      ? cafe.photos![0]
                      : null,
                )
              : null;

          final userBookingData = UserBookingData(
            id: booking.id,
            bookingCode: booking.bookingCode,
            cafeId: booking.cafeId,
            status: booking.status,
            checkInStatus: booking.checkInStatus,
            startTime: booking.startTime,
            endTime: booking.endTime,
            bookingDate: booking.bookingDate,
            bookingDay: booking.bookingDay,
            durationHours: booking.durationHours,
            price: booking.price,
            cafe: bookingCafe,
          );

          Get.toNamed(AppRoutes.myBookingScreenRoute,
              arguments: userBookingData);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.black,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: accentColor.withOpacity(0.5), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: accentColor, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.checkInStatus == "checked_in"
                          ? "Currently Checked-in"
                          : "Upcoming Booking",
                      style: PMT.style(12,
                          fontColor: accentColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cafe?.name ?? "Yellow Space",
                      style: PMT.style(16,
                          fontColor: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "DETAILS",
                  style: PMT.style(10,
                      fontColor: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerAds(BuildContext context, bool isDark) {
    return Obx(() {
      if (controller.isAdsLoading.value) {
        return _buildBannerShimmer();
      }

      if (controller.bannerAds.isEmpty) {
        return const SizedBox.shrink();
      }

      return SizedBox(
        height: 180,
        child: PageView.builder(
          controller: _pageController,
          itemCount: controller.bannerAds.length,
          onPageChanged: (index) {
            // Optional: dots logic
          },
          itemBuilder: (context, index) {
            final ad = controller.bannerAds[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Bounce(
                onTap: () => Get.toNamed(
                  AppRoutes.cafeDetailsScreenRoute,
                  arguments: ad,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage((ad.photos != null &&
                              ad.photos!.isNotEmpty)
                          ? "${ApiEndPoints.imageBaseUrl}${ad.photos![0]}"
                          : "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 0,
                        bottom: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "PROMOTED",
                                style: PMT.style(10,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ad.name ?? "",
                              style: PMT.style(22,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white70, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  ad.city ?? "Location",
                                  style:
                                      PMT.style(14, fontColor: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildBannerShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ShimmerWidget.rectangular(
        height: 180,
        width: double.infinity,
        // borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark, Color textColor) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.searchScreenRoute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: isDark ? Colors.grey.shade700 : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(Icons.search,
                color: isDark ? Colors.grey : Colors.grey.shade600),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Search cafe, co-workers",
                style: PMT.style(14,
                    fontColor: isDark ? Colors.grey : Colors.grey.shade600),
              ),
            ),
            Icon(Icons.tune,
                color: isDark ? Colors.grey : Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context, bool isDark) {
    return Obx(() {
      if (controller.isCafeLoading.value) {
        return _buildFeaturedShimmer();
      }

      if (controller.featuredCafes.isEmpty) {
        return SizedBox(
          height: 280,
          child: Center(
            child: Text(
              "No featured cafes found",
              style: PMT.style(14,
                  fontColor: isDark ? Colors.white : Colors.black),
            ),
          ),
        );
      }

      return SizedBox(
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.featuredCafes.length,
          itemBuilder: (context, index) {
            final cafe = controller.featuredCafes[index];
            return _buildAnimatedItem(
              index,
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Bounce(
                  onTap: () => Get.toNamed(
                    AppRoutes.cafeDetailsScreenRoute,
                    arguments: cafe,
                  ),
                  child: Container(
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage((cafe.photos != null &&
                                cafe.photos!.isNotEmpty)
                            ? "${ApiEndPoints.imageBaseUrl}${cafe.photos![0]}"
                            : "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient overlay for better text visibility
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                              stops: const [0.0, 0.3, 0.6, 1.0],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Row(
                            children: [
                              const Icon(Icons.verified,
                                  color: ColorConstant.primaryColor, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "Featured",
                                style: PMT.style(12,
                                    fontColor: ColorConstant.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        if (false) // Hide mock discount
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "10% OFF",
                                style: PMT.style(10,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cafe.name ?? "Cafe Name",
                                style: PMT.style(18,
                                    fontColor: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.white70, size: 12),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "${cafe.address}, ${cafe.city}",
                                      style: PMT.style(12,
                                          fontColor: Colors.white70),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: ColorConstant.primaryColor,
                                          size: 14),
                                      const SizedBox(width: 4),
                                      Text(
                                        cafe.rating ?? "0.0",
                                        style: PMT.style(12,
                                            fontColor:
                                                ColorConstant.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.wifi,
                                          color: Colors.white, size: 14),
                                      SizedBox(width: 8),
                                      Icon(Icons.bolt,
                                          color: Colors.white, size: 14),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildFeaturedShimmer() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ShimmerWidget.rectangular(
              width: 220,
              height: 280,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories(
      BuildContext context, bool isDark, Color accentColor) {
    return SizedBox(
      height: 40,
      child: Obx(() {
        if (controller.categories.isEmpty && !controller.isCafeLoading.value) {
          return const SizedBox.shrink();
        }
        return Obx(
          () => ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  debugPrint(
                      "Category ${controller.categories[index]} selected");
                  controller.filterCafes(index);
                },
                child: Obx(
                  () => Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: controller.selectedCategoryIndex.value == index
                          ? (isDark ? Colors.grey.shade800 : Colors.black)
                          : (isDark
                              ? const Color(0xFF2C2C2C)
                              : Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: controller.selectedCategoryIndex.value == index
                            ? (isDark ? Colors.grey.shade800 : Colors.black)
                            : (isDark
                                ? const Color(0xFF2C2C2C)
                                : Colors.grey.shade200),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        controller.categories[index],
                        style: PMT.style(12,
                            fontColor: controller.selectedCategoryIndex.value ==
                                    index
                                ? Colors.white
                                : (isDark ? Colors.grey : Colors.grey.shade600),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildRecommendedSection(BuildContext context, bool isDark,
      Color textColor, Color subTextColor, Color cardColor, Color accentColor) {
    return Obx(() {
      if (controller.isCafeLoading.value) {
        return _buildRecommendedShimmer(isDark, cardColor);
      }
      if (controller.filteredCafes.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Icon(Icons.search_off, size: 48, color: subTextColor),
                const SizedBox(height: 16),
                Text(
                  "No cafes available in this category",
                  style: PMT.style(14, fontColor: subTextColor),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.filteredCafes.length,
        itemBuilder: (context, index) {
          final cafe = controller.filteredCafes[index];
          return _buildAnimatedItem(
            index,
            GestureDetector(
              onTap: () => Get.toNamed(
                AppRoutes.cafeDetailsScreenRoute,
                arguments: cafe,
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24)),
                          child: CustomImageView(
                            url: (cafe.photos != null &&
                                    cafe.photos!.isNotEmpty)
                                ? "${ApiEndPoints.imageBaseUrl}${cafe.photos![0]}"
                                : "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (false) // Hide mock discount
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "10% OFF",
                                style: PMT.style(10,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${cafe.totalSeats ?? 0} Seats",
                              style: PMT.style(10, fontColor: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cafe.name ?? "Cafe Name",
                                style: PMT.style(18,
                                    fontColor: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: ColorConstant.primaryColor,
                                      size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    cafe.rating ?? "0.0",
                                    style: PMT.style(12,
                                        fontColor: textColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: subTextColor, size: 14),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${cafe.address}, ${cafe.city}",
                                  style: PMT.style(12, fontColor: subTextColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cafe.description ?? "No description available",
                            style: PMT.style(12, fontColor: subTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildAmenityChip(Icons.wifi, "Wi-fi", isDark),
                              const SizedBox(width: 8),
                              _buildAmenityChip(
                                  Icons.pets, "PetFriendly", isDark),
                              const SizedBox(width: 8),
                              _buildAmenityChip(
                                  Icons.bolt, "PowerOutrage", isDark),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildRecommendedShimmer(bool isDark, Color cardColor) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const ShimmerWidget.rectangular(
                width: 100,
                height: 100,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerWidget.rectangular(height: 15, width: 80),
                    SizedBox(height: 8),
                    ShimmerWidget.rectangular(height: 20),
                    SizedBox(height: 8),
                    ShimmerWidget.rectangular(height: 15, width: 120),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmenityChip(IconData icon, String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon,
              size: 12, color: isDark ? Colors.grey : Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            label,
            style: PMT.style(10,
                fontColor: isDark ? Colors.grey : Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final animation = CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (index * 0.1).clamp(0.0, 1.0),
            1.0,
            curve: Curves.easeOut,
          ),
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
