import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/presentation/notification_screen/controller/notification_controller.dart';
import 'package:yellow_pass/data/models/notification_response_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late NotificationController controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<NotificationController>();
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
    
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
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
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (controller.notifications.isEmpty) {
                  return Center(
                    child: Text(
                      "No notifications found",
                      style: PMT.style(14, fontColor: subTextColor),
                    ),
                  );
                }

                final grouped = controller.groupedNotifications;
                final sections = grouped.keys.toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: sections.length,
                  itemBuilder: (context, sectionIndex) {
                    final type = sections[sectionIndex];
                    final sectionNotifications = grouped[type]!;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            type.toUpperCase(),
                            style: PMT.style(12, fontColor: Colors.yellow, fontWeight: FontWeight.bold, ),
                          ),
                        ),
                        ...List.generate(sectionNotifications.length, (index) {
                          final notification = sectionNotifications[index];
                          return _buildAnimatedItem(
                            index + (sectionIndex * 10), // Unique index for animation
                            _buildNotificationItem(context, notification, isDark, textColor, subTextColor, cardColor),
                          );
                        }),
                      ],
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
              "Notifications",
              style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),

      ],
    );
  }

  Widget _buildNotificationItem(BuildContext context, NotificationData notification, bool isDark, Color textColor, Color subTextColor, Color cardColor) {
    IconData iconData;
    Color iconColor;
    
    switch (notification.type) {
      case 'booking':
        iconData = Icons.bookmark_added;
        iconColor = Colors.blue;
        break;
      case 'offer':
        iconData = Icons.local_offer;
        iconColor = Colors.orange;
        break;
      case 'reminder':
        iconData = Icons.notifications_active;
        iconColor = Colors.green;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.grey;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title ?? "",
                        style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (notification.read == false)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message ?? "",
                  style: PMT.style(12, fontColor: subTextColor, fontWeight: FontWeight.w400),
                ),
              ],
            ),
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
            (index * 0.05).clamp(0.0, 1.0), // Faster staggered animation
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
