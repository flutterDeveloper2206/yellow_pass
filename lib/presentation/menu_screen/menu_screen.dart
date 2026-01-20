import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/widgets/bouncing_button.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'controller/menu_controller.dart' as menu_ctrl;
import '../../ApiServices/api_end_points.dart';
import '../../core/utils/color_constant.dart';

class MenuScreen extends GetView<menu_ctrl.MenuController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Project standard colors
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
        title: Text(
          "${controller.cafe.value?.name ?? 'Cafe'} Menu",
          style:
              PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.menuItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu,
                    size: 60, color: subTextColor.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text(
                  "No menu items available",
                  style: PMT.style(14, fontColor: subTextColor),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: controller.menuItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = controller.menuItems[index];
            final itemId = item.id ?? "";

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomImageView(
                      url: item.imageUrl != null
                          ? "${ApiEndPoints.imageBaseUrl}${item.imageUrl}"
                          : null,
                      height: 90,
                      width: 90,
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
                          style: PMT.style(16,
                              fontColor: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description ?? "",
                          style: PMT.style(12, fontColor: subTextColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹${item.price}",
                              style: PMT.style(18,
                                  fontColor: textColor,
                                  fontWeight: FontWeight.w900),
                            ),
                            Obx(() {
                              final currentQty =
                                  controller.itemQuantities[itemId] ?? 0;

                              if (currentQty == 0) {
                                return Bounce(
                                  onTap: () =>
                                      controller.incrementQuantity(itemId),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: accentColor
                                          .withOpacity(isDarkMode ? 0.2 : 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: accentColor.withOpacity(0.5)),
                                    ),
                                    child: Text(
                                      "ADD",
                                      style: PMT.style(14,
                                          fontColor: textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }

                              return Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove,
                                          size: 16, color: textColor),
                                      onPressed: () =>
                                          controller.decrementQuantity(itemId),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      child: Center(
                                        child: Text(
                                          "$currentQty",
                                          style: PMT.style(14,
                                              fontColor: textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add,
                                          size: 16, color: textColor),
                                      onPressed: () =>
                                          controller.incrementQuantity(itemId),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        if (!controller.hasItemsInCart) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Amount",
                        style: PMT.style(12, fontColor: subTextColor),
                      ),
                      Text(
                        "₹${controller.totalPrice.toStringAsFixed(2)}",
                        style: PMT.style(24,
                            fontColor: textColor, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Bounce(
                    onTap: () => _showOrderConfirmation(context),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Order Now",
                          style: PMT.style(16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
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
                  color: ColorConstant.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.shopping_basket_rounded,
                    size: 40, color: ColorConstant.primaryColor),
              ),
              const SizedBox(height: 20),
              Text(
                "Confirm Order",
                style: PMT.style(20,
                    fontColor: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: PMT.style(14,
                      fontColor: isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade600),
                  children: [
                    const TextSpan(
                        text:
                            "Are you sure you want to place this order worth "),
                    TextSpan(
                      text: "₹${controller.totalPrice.toStringAsFixed(2)}",
                      style: PMT.style(14,
                          fontColor: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: "?"),
                  ],
                ),
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
                        controller.placeOrder();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: ColorConstant.primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text("Confirm",
                              style: PMT.style(16,
                                  fontColor: Colors.black,
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
