import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/controller/my_bookings_controller.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/widgets/shimmer_widget.dart';
import 'package:yellow_pass/data/models/user_booking_response_model.dart';
import 'package:yellow_pass/ApiServices/api_end_points.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/write_review_screen.dart';

import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late MyBookingsController controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MyBookingsController>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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

    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildAppBar(context, textColor, isDark),
            ),
            _buildTabSwitcher(context, isDark),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _buildShimmerList(isDark, cardColor);
                }

                final bookings = controller.selectedTabIndex.value == 0
                    ? controller.upcomingBookings
                    : controller.pastBookings;

                if (bookings.isEmpty) {
                  return _buildEmptyState(textColor, isDark);
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        final animation = CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            (index / (bookings.isEmpty ? 1 : bookings.length)) *
                                0.5,
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
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.myBookingScreenRoute,
                                  arguments: booking)
                              ?.then(
                            (value) {
                              controller.fetchUserBookings();
                            },
                          );
                        },
                        child: _buildBookingCard(
                            context, booking, isDark, textColor, cardColor),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Color textColor, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, size: 20, color: textColor),
            ),
            const SizedBox(width: 8),
            Text(
              "My Bookings",
              style: PMT.style(18,
                  fontColor: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabSwitcher(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Obx(() => Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeTab(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: controller.selectedTabIndex.value == 0
                          ? ColorConstant.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Upcoming Bookings",
                      textAlign: TextAlign.center,
                      style: PMT.style(
                        12,
                        fontColor: controller.selectedTabIndex.value == 0
                            ? Colors.black
                            : (isDark ? Colors.grey : Colors.black54),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeTab(1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: controller.selectedTabIndex.value == 1
                          ? ColorConstant.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Past Bookings",
                      textAlign: TextAlign.center,
                      style: PMT.style(
                        12,
                        fontColor: controller.selectedTabIndex.value == 1
                            ? Colors.black
                            : (isDark ? Colors.grey : Colors.black54),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildBookingCard(BuildContext context, UserBookingData booking,
      bool isDark, Color textColor, Color cardColor) {
    String imageUrl = "";
    if (booking.cafe?.image != null) {
      imageUrl = booking.cafe!.image!.startsWith('/')
          ? "${ApiEndPoints.imageBaseUrl}" + booking.cafe!.image!
          : booking.cafe!.image!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: booking.checkInStatus == 'checked_in'
            ? Border.all(color: Colors.green, width: 2)
            : null,
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: booking.checkInStatus == 'checked_in'
                      ? Colors.green.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomImageView(
                  url: imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            booking.cafe?.name ?? "N/A",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: PMT.style(16,
                                fontColor: textColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (booking.review?.rating != null)
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 14, color: ColorConstant.primaryColor),
                              const SizedBox(width: 2),
                              Text(
                                booking.review!.rating.toString(),
                                style: PMT.style(12, fontColor: Colors.grey),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            booking.cafe?.address ?? "N/A",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: PMT.style(12, fontColor: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          booking.bookingDate ?? "N/A",
                          style: PMT.style(12,
                              fontColor: textColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          "${booking.startTime} - ${booking.endTime}",
                          style: PMT.style(10,
                              fontColor: textColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF332F00)
                        : const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      booking.status?.toUpperCase() ?? "BOOKED",
                      style: PMT.style(12,
                          fontColor: isDark
                              ? ColorConstant.primaryColor
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              if (booking.status == 'completed') ...[
                if (booking.review == null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => WriteReviewScreen(booking: booking))
                            ?.then((value) {
                          controller.fetchUserBookings();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Write Review",
                            style: PMT.style(12,
                                fontColor: ColorConstant.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle,
                              size: 16, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            "Reviewed",
                            style: PMT.style(12,
                                fontColor: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ] else if (booking.status != 'completed' &&
                  booking.checkInStatus != 'checked_in')
                if (booking.type == "upcoming") ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showCancelConfirmationDialog(context, booking);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red.shade300),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel Booking",
                            style: PMT.style(12,
                                fontColor: Colors.red.shade300,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
            ],
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmationDialog(
      BuildContext context, UserBookingData booking) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.warning_amber_rounded,
                    color: Colors.red, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                "Cancel Booking?",
                style: PMT.style(20,
                    fontColor: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "Are you sure you want to cancel this booking for ${booking.cafe?.name}?",
                textAlign: TextAlign.center,
                style: PMT.style(14, fontColor: Colors.grey),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "No, Keep it",
                        style: PMT.style(14,
                            fontColor: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.cancelBooking(booking);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Yes, Cancel",
                        style: PMT.style(14,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerList(bool isDark, Color cardColor) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const ShimmerWidget.rectangular(height: 80, width: 80),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerWidget.rectangular(height: 20, width: 150),
                        SizedBox(height: 8),
                        ShimmerWidget.rectangular(height: 15, width: 200),
                        SizedBox(height: 8),
                        ShimmerWidget.rectangular(height: 15, width: 100),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(child: ShimmerWidget.rectangular(height: 40)),
                  SizedBox(width: 12),
                  Expanded(child: ShimmerWidget.rectangular(height: 40)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(Color textColor, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined,
              size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text(
            "No bookings found",
            style: PMT.style(18,
                fontColor: textColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "You haven't made any bookings yet.",
            style: PMT.style(14, fontColor: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text("Book Now",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
