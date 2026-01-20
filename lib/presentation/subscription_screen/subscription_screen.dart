import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/widgets/bouncing_button.dart';
import 'controller/subscription_controller.dart';
import '../../../data/models/subscription_response_model.dart';
import '../../core/utils/color_constant.dart';
import '../../../data/models/user_response_model.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Subscriptions',
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
        if (controller.isLoading.value) {
          return Center(
              child:
                  CircularProgressIndicator(color: theme.colorScheme.primary));
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            if (controller.activeSubscription.value != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 4),
                child: Text(
                  'Your Active Subscription',
                  style: PMT.style(18,
                      fontColor: textColor, fontWeight: FontWeight.bold),
                ),
              ),
              ActiveSubscriptionCard(
                activeSub: controller.activeSubscription.value!,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 4),
                child: Text(
                  'Upgrade or Change Plan',
                  style: PMT.style(18,
                      fontColor: textColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            if (controller.subscriptions.isEmpty &&
                controller.activeSubscription.value == null)
              SizedBox(
                height: Get.height * 0.6,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.subscriptions_outlined,
                          size: 80, color: textColor.withOpacity(0.2)),
                      const SizedBox(height: 24),
                      Text(
                        'No subscription plans available',
                        style: PMT.style(14,
                            fontColor: textColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...controller.subscriptions.map((plan) => SubscriptionCard(
                    plan: plan,
                    onTap: () => _showConfirmationDialog(context, plan),
                  )),
          ],
        );
      }),
    );
  }

  void _showConfirmationDialog(BuildContext context, SubscriptionData plan) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Confirm Purchase',
                style: PMT.style(20,
                    fontColor: textColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: PMT
                      .style(14, fontColor: subTextColor)
                      .copyWith(height: 1.5),
                  children: [
                    const TextSpan(text: 'Are you sure you want to purchase '),
                    TextSpan(
                      text: '${plan.name}',
                      style: PMT.style(14,
                          fontColor: textColor, fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' for '),
                    TextSpan(
                      text: '₹${plan.price}',
                      style: PMT.style(14,
                          fontColor: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '?'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: PMT.style(16,
                            fontColor: subTextColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Bounce(
                      onTap: () {
                        Get.back();
                        controller.buySubscription(plan.id!);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
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
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveSubscriptionCard extends StatelessWidget {
  final ActiveSubscription activeSub;

  const ActiveSubscriptionCard({super.key, required this.activeSub});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = const Color(0xFF4F46E5);
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accentColor.withOpacity(isDark ? 0.3 : 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(Icons.stars_rounded, color: accentColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activeSub.subscription?.name ?? 'Premium Plan',
                        style: PMT.style(18,
                            fontColor: textColor, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Renews on ${_formatDate(activeSub.endDate)}',
                        style: PMT.style(12,
                            fontColor: subTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Active',
                    style: PMT.style(10,
                        fontColor: Colors.green, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.03)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    label: 'Discount',
                    value:
                        '${activeSub.subscription?.discountPercentage ?? 0}%',
                  ),
                  Container(
                      width: 1, height: 24, color: textColor.withOpacity(0.05)),
                  _buildStatItem(
                    label: 'Bonus',
                    value: '${activeSub.subscription?.bonusTokens ?? 0}',
                  ),
                  Container(
                      width: 1, height: 24, color: textColor.withOpacity(0.05)),
                  _buildStatStatItem(
                    label: 'Price',
                    value:
                        '₹${activeSub.subscription?.price?.split('.').first}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({required String label, required String value}) {
    final isDark = Get.isDarkMode;
    return Column(
      children: [
        Text(
          label,
          style: PMT.style(11,
              fontColor: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: PMT.style(14,
              fontColor: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _buildStatStatItem({required String label, required String value}) {
    return _buildStatItem(label: label, value: value);
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return "${date.day} ${months[date.month - 1]}, ${date.year}";
    } catch (e) {
      return dateStr;
    }
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionData plan;
  final VoidCallback onTap;

  const SubscriptionCard({
    super.key,
    required this.plan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final accentColor = theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      accentColor.withOpacity(0.15),
                      accentColor.withOpacity(0),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                          border:
                              Border.all(color: accentColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          plan.name ?? '',
                          style: PMT.style(12,
                              fontColor: isDark ? accentColor : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (plan.discountPercentage != null &&
                          plan.discountPercentage! > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${plan.discountPercentage}% OFF',
                            style: PMT.style(12,
                                fontColor: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '₹${plan.price}',
                        style: PMT.style(28,
                            fontColor: textColor, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '/ ${plan.durationDays} Days',
                        style: PMT.style(14,
                            fontColor: subTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (plan.bonusTokens != null && plan.bonusTokens! > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorConstant.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars_rounded,
                              color: ColorConstant.primaryColor, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '${plan.bonusTokens} Bonus Tokens included',
                            style: PMT.style(12,
                                fontColor: isDark
                                    ? ColorConstant.primaryColor
                                    : ColorConstant.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    plan.description ?? '',
                    style: PMT
                        .style(14, fontColor: subTextColor)
                        .copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 28),
                  Bounce(
                    onTap: onTap,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          'Subscribe Now',
                          style: PMT.style(18,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
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
}
