import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/core/utils/image_constant.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'package:yellow_pass/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/widgets/bouncing_button.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late HomeScreenController controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeScreenController());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final accentColor = const Color(0xFFFFD54F);

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
              const SizedBox(height: 30),
              _buildFeaturedSection(context, isDark),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Explore Yellow Spaces",
                  style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              _buildCategories(context, isDark, accentColor),
              const SizedBox(height: 20),
              _buildRecommendedSection(context, isDark, textColor, subTextColor, cardColor, accentColor),
              const SizedBox(height: 80), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color textColor, bool isDark, Color accentColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to profile or open drawer
            Get.toNamed(AppRoutes.profileScreenRoute);
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accentColor, width: 2),
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop',
              ),
            ),
          ),
        ),
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: textColor),
            const SizedBox(width: 4),
            Text(
              "Navi Peth, Pune",
              style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
             if (isDark) ...[
               Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.yellow, width: 1),
                  color: Colors.transparent,
                ),
                child: const Icon(Icons.visibility, size: 18, color: Colors.yellow),
              ),
              const SizedBox(width: 10),
            ],
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.notificationScreenRoute);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200,
                ),
                child: Icon(Icons.notifications_outlined, size: 20, color: isDark ? Colors.grey : Colors.black54),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.transparent),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: isDark ? Colors.grey : Colors.grey.shade600),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Search cafe, co-workers",
              style: PMT.style(14, fontColor: isDark ? Colors.grey : Colors.grey.shade600),
            ),
          ),
          Icon(Icons.tune, color: isDark ? Colors.grey : Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context, bool isDark) {
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
                      image: NetworkImage(cafe['image']),
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
                            const Icon(Icons.verified, color: Colors.yellow, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              "Featured",
                              style: PMT.style(12, fontColor: Colors.yellow, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            cafe['discount'],
                            style: PMT.style(10, fontColor: Colors.black, fontWeight: FontWeight.bold),
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
                              cafe['name'],
                              style: PMT.style(18, fontColor: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.white70, size: 12),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    cafe['location'],
                                    style: PMT.style(12, fontColor: Colors.white70),
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
                                    const Icon(Icons.star, color: Colors.yellow, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      cafe['rating'],
                                      style: PMT.style(12, fontColor: Colors.yellow, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.wifi, color: Colors.white, size: 14),
                                    SizedBox(width: 8),
                                    Icon(Icons.bolt, color: Colors.white, size: 14),
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
  }

  Widget _buildCategories(BuildContext context, bool isDark, Color accentColor) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.selectedCategoryIndex.value == index;
            return GestureDetector(
              onTap: () => controller.selectedCategoryIndex.value = index,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? (isDark ? Colors.grey.shade800 : Colors.black) : (isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.transparent),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.category, // Placeholder icon
                      size: 16,
                      color: isSelected ? Colors.white : (isDark ? Colors.grey : Colors.grey.shade600),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.categories[index],
                      style: PMT.style(12, fontColor: isSelected ? Colors.white : (isDark ? Colors.grey : Colors.grey.shade600), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildRecommendedSection(BuildContext context, bool isDark, Color textColor, Color subTextColor, Color cardColor, Color accentColor) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: controller.recommendedCafes.length,
      itemBuilder: (context, index) {
        final cafe = controller.recommendedCafes[index];
        return _buildAnimatedItem(
          index + 5, // Stagger after featured items
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Bounce(
              onTap: () => Get.toNamed(
                AppRoutes.cafeDetailsScreenRoute,
                arguments: cafe,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.network(
                            cafe['image'],
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Gradient overlay for better text visibility
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                              stops: const [0.0, 0.25, 0.7, 1.0],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              cafe['discount'],
                              style: PMT.style(10, fontColor: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              cafe['seats'],
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
                                cafe['name'],
                                style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.white, size: 14), // Star color white in dark mode design? Or yellow? Design shows white star with rating text
                                  const SizedBox(width: 4),
                                  Text(
                                    cafe['rating'],
                                    style: PMT.style(12, fontColor: textColor, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: subTextColor, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                cafe['location'],
                                style: PMT.style(12, fontColor: subTextColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cafe['description'],
                            style: PMT.style(12, fontColor: subTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildAmenityChip(Icons.wifi, "Wi-fi", isDark),
                              const SizedBox(width: 8),
                              _buildAmenityChip(Icons.pets, "PetFriendly", isDark),
                              const SizedBox(width: 8),
                              _buildAmenityChip(Icons.bolt, "PowerOutrage", isDark),
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
          Icon(icon, size: 12, color: isDark ? Colors.grey : Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            label,
            style: PMT.style(10, fontColor: isDark ? Colors.grey : Colors.grey.shade700),
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
