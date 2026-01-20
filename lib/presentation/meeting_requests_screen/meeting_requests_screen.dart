import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/utils/app_fonts.dart';
import '../../widgets/bouncing_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../ApiServices/api_end_points.dart';
import 'controller/meeting_requests_controller.dart';
import '../../data/models/meeting_list_response_model.dart';
import '../../core/utils/color_constant.dart';

class MeetingRequestsScreen extends GetView<MeetingRequestsController> {
  const MeetingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        appBar: AppBar(
          backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Meeting Requests",
            style: PMT.style(18,
                fontColor: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: ColorConstant.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: ColorConstant.primaryColor,
            unselectedLabelColor:
                isDarkMode ? Colors.grey : Colors.grey.shade600,
            labelStyle: PMT.style(14, fontWeight: FontWeight.bold),
            unselectedLabelStyle: PMT.style(14, fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: "My Requests"),
              Tab(text: "Other Requests"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRequestList(context, false),
            _buildRequestList(context, true),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestList(BuildContext context, bool isIncoming) {
    return Obx(() {
      final isLoading = isIncoming
          ? controller.isLoadingIncoming.value
          : controller.isLoadingSent.value;
      final requests =
          isIncoming ? controller.incomingRequests : controller.sentRequests;

      if (isLoading && requests.isEmpty) {
        return const Center(
            child:
                CircularProgressIndicator(color: ColorConstant.primaryColor));
      }

      if (requests.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.handshake_outlined,
                  size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                "No requests found",
                style: PMT.style(16, fontColor: Colors.grey.shade500),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        color: ColorConstant.primaryColor,
        onRefresh: () async {
          if (isIncoming) {
            await controller.fetchIncomingRequests();
          } else {
            await controller.fetchSentRequests();
          }
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            return _buildRequestCard(context, requests[index], isIncoming);
          },
        ),
      );
    });
  }

  Widget _buildRequestCard(
      BuildContext context, MeetingRequest request, bool isIncoming) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final otherUser = isIncoming ? request.sender : request.receiver;

    final profilePic = otherUser?.profilePicture ??
        "${ApiEndPoints.imageBaseUrl}/storage/profile-pictures/default.png";
    final fullProfilePic = profilePic.startsWith("http")
        ? profilePic
        : "${ApiEndPoints.imageBaseUrl}$profilePic";

    final dateStr = request.createdAt != null
        ? DateFormat('dd MMM yyyy, hh:mm a')
            .format(DateTime.parse(request.createdAt!))
        : "";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.grey.shade100,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomImageView(
                    url: fullProfilePic,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        otherUser?.name ?? "Unknown User",
                        style: PMT.style(16,
                            fontColor: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dateStr,
                        style: PMT.style(12, fontColor: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(request.status ?? "pending"),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.03)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                request.message ?? "No message provided",
                style: PMT.style(14,
                    fontColor: isDarkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade800),
              ),
            ),
            if (isIncoming && request.status == "pending") ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Bounce(
                      onTap: () =>
                          _showResponseSheet(context, request.id!, "rejected"),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            "Reject",
                            style: PMT.style(14,
                                fontColor: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Bounce(
                      onTap: () =>
                          _showResponseSheet(context, request.id!, "accepted"),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: ColorConstant.primaryColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            "Approve",
                            style: PMT.style(14,
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
            if (request.responseMessage != null &&
                request.responseMessage!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                "Response: ${request.responseMessage}",
                style: PMT.style(13,
                    fontColor: ColorConstant.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'accepted':
        color = Colors.green;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      default:
        color = ColorConstant.primaryColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.capitalizeFirst!,
        style: PMT.style(12, fontColor: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showResponseSheet(BuildContext context, int id, String status) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController responseController = TextEditingController();
    final actionText = status == "accepted" ? "Approve" : "Reject";
    final actionColor =
        status == "accepted" ? ColorConstant.primaryColor : Colors.red;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$actionText Request",
              style: PMT.style(20,
                  fontColor: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Add a message to your response (optional).",
              style: PMT.style(14, fontColor: Colors.grey.shade500),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: responseController,
              maxLines: 3,
              style: PMT.style(14,
                  fontColor: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: PMT.style(14, fontColor: Colors.grey),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 24),
            Bounce(
              onTap: () {
                Get.back();
                controller.respondToRequest(
                    id, status, responseController.text.trim());
              },
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: actionColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Text(
                    "Confirm $actionText",
                    style: PMT.style(16,
                        fontColor:
                            status == "accepted" ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
