import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/my_booking_controller.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/data/models/booking_detail_response_model.dart';
import 'package:yellow_pass/widgets/shimmer_widget.dart';

class MyBookingScreen extends GetView<MyBookingController> {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Booking Details",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerView(isDark);
        }
        
        final booking = controller.bookingDetails.value;
        if (booking == null) {
          return const Center(child: Text("Booking details not found"));
        }

        String imageUrl = "";
        if (booking.cafe?.image != null) {
          imageUrl = booking.cafe!.image!.startsWith('/') 
            ? "https://api.yellowpass.in" + booking.cafe!.image!
            : booking.cafe!.image!;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cafe Info Card
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'booking_${booking.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CustomImageView(
                            url: imageUrl,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.cafe?.name ?? "N/A",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              booking.cafe?.address ?? "N/A",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(booking.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                booking.status?.toUpperCase() ?? "BOOKED",
                                style: TextStyle(
                                  color: _getStatusColor(booking.status),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Booking Details Section
              _buildSectionTitle("Booking Details", isDark),
              const SizedBox(height: 12),
              _buildDetailContainer(isDark, [
                _buildDetailRow("Booking Code", booking.bookingCode ?? "N/A", Icons.confirmation_number_outlined, isDark),
                _buildDetailRow("Date", booking.bookingDate ?? "N/A", Icons.calendar_today_outlined, isDark),
                _buildDetailRow("Start Time", "${booking.startTime}", Icons.access_time, isDark),
                _buildDetailRow("End Time", "${booking.endTime}", Icons.access_time, isDark),
                _buildDetailRow("Table", booking.table?.tableNumber ?? "N/A", Icons.chair_alt_outlined, isDark),
                _buildDetailRow("Duration", "${booking.durationHours} Hours", Icons.timer_outlined, isDark),
                _buildDetailRow("Price", "${booking.price} Tokens", Icons.token_outlined, isDark),
                if (booking.checkedInAt != null)
                   _buildDetailRow("Check-in At", booking.checkedInAt!, Icons.login, isDark),
                if (booking.checkedOutAt != null)
                   _buildDetailRow("Check-out At", booking.checkedOutAt!, Icons.logout, isDark),
              ]),
              
              const SizedBox(height: 24),
              

              const SizedBox(height: 100), // Space for bottom button
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final booking = controller.bookingDetails.value;
        if (booking == null) return const SizedBox.shrink();

        // check_in_status == panding then show check in button
        // check_in_status == checked_in then show check out button
        // check_in_status == checked_out then dont show any button

        if (booking.checkInStatus == "checked_out") {
          return const SizedBox.shrink();
        }

        return FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                if (booking.checkInStatus == "checked_in") {
                  controller.checkOut();
                } else if (booking.checkInStatus == "pending") {
                  controller.checkIn();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: booking.checkInStatus == "checked_in" ? Colors.red : (isDark ? Colors.white : Colors.black),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                booking.checkInStatus == "checked_in" ? "Check Out" : "Check In",
                style: TextStyle(
                  color: booking.checkInStatus == "checked_in" ? Colors.white : (isDark ? Colors.black : Colors.white),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return FadeInLeft(
      delay: const Duration(milliseconds: 200),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildDetailContainer(bool isDark, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.yellow.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  Widget _buildShimmerView(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cafe Info Card Shimmer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const ShimmerWidget.rectangular(height: 80, width: 80),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerWidget.rectangular(height: 20, width: 150),
                      const SizedBox(height: 8),
                      const ShimmerWidget.rectangular(height: 14, width: 200),
                      const SizedBox(height: 8),
                      const ShimmerWidget.rectangular(height: 20, width: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Booking Details Shimmer
          const ShimmerWidget.rectangular(height: 24, width: 150),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
            ),
            child: Column(
              children: List.generate(6, (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ShimmerWidget.rectangular(height: 16, width: 100),
                    const ShimmerWidget.rectangular(height: 16, width: 100),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
