import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/utils/app_fonts.dart';
import '../../widgets/bouncing_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../ApiServices/api_end_points.dart';
import '../../core/utils/color_constant.dart';
import 'controller/my_orders_controller.dart';

class MyOrdersScreen extends GetView<MyOrdersController> {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subTextColor =
        isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final accentColor = ColorConstant.primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "My Orders",
          style:
              PMT.style(20, fontColor: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined,
                    size: 80, color: subTextColor.withOpacity(0.5)),
                const SizedBox(height: 16),
                Text(
                  "No orders yet",
                  style: PMT.style(18,
                      fontColor: subTextColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchOrders(),
          color: accentColor,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.orders.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return _buildOrderCard(context, order, isDarkMode, cardColor,
                  textColor, subTextColor, accentColor);
            },
          ),
        );
      }),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    dynamic order,
    bool isDarkMode,
    Color cardColor,
    Color textColor,
    Color subTextColor,
    Color accentColor,
  ) {
    final statusColor = _getStatusColor(order.status ?? "");
    final statusIcon = _getStatusIcon(order.status ?? "");
    final formattedDate = _formatDate(order.createdAt ?? "");

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.grey.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.4 : 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          children: [
            // Status & Date Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(statusIcon, size: 16, color: statusColor),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.status?.toUpperCase() ?? "",
                            style: PMT.style(12,
                                fontColor: statusColor,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            formattedDate,
                            style: PMT.style(11, fontColor: subTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "#${order.id?.substring(0, 8).toUpperCase()}",
                    style: PMT.style(12,
                        fontColor: subTextColor,
                        fontWeight:
                            FontWeight.w900), // Changed from FontWeight.bold
                  ),
                ],
              ),
            ),

            // Items Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Details",
                    style: PMT.style(14,
                        fontColor: textColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...(order.items as List).map<Widget>((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.03)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomImageView(
                              url:
                                  '${ApiEndPoints.imageBaseUrl}${item.imageUrl}',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? "",
                                  style: PMT.style(14,
                                      fontColor: textColor,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Qty: ${item.quantity}",
                                  style: PMT.style(12, fontColor: subTextColor),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "₹${item.price}",
                            style: PMT.style(16,
                                fontColor: textColor,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Footer Total
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.02)
                    : Colors.grey.shade50,
                border: Border(
                  top: BorderSide(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey.shade100,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TOTAL PAYABLE",
                        style: PMT.style(10,
                            fontColor: subTextColor,
                            fontWeight: FontWeight
                                .w900), // Changed from FontWeight.black
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "₹${order.totalAmount}",
                        style: PMT.style(22,
                            fontColor: accentColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  if (order.status?.toLowerCase() == "pending")
                    Bounce(
                      onTap: () =>
                          _showCancelConfirmation(context, order.id ?? ""),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.red.withOpacity(0.2)),
                        ),
                        child: Text(
                          "Cancel Order",
                          style: PMT.style(13,
                              fontColor: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ColorConstant.primaryColor;
      case 'completed':
        return Colors.green.shade600;
      case 'cancelled':
        return Colors.red.shade600;
      default:
        return Colors.blue.shade600;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.access_time_filled_rounded;
      case 'completed':
        return Icons.check_circle_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  void _showCancelConfirmation(BuildContext context, String orderId) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade400.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.warning_amber_rounded,
                    size: 40, color: Colors.red.shade400),
              ),
              const SizedBox(height: 20),
              Text(
                "Cancel Order?",
                style: PMT.style(20,
                    fontColor: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "Are you sure you want to cancel this order? This action cannot be undone.",
                textAlign: TextAlign.center,
                style: PMT.style(14,
                    fontColor: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Close",
                          style: PMT.style(16,
                              fontColor: isDarkMode
                                  ? Colors.white54
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Bounce(
                      onTap: () {
                        Get.back();
                        controller.cancelOrder(orderId);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text("Confirm",
                              style: PMT.style(16,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
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
}
