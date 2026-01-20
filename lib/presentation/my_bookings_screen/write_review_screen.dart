import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellow_pass/core/utils/commonConstant.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/data/models/user_booking_response_model.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/controller/my_bookings_controller.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import '../../ApiServices/api_end_points.dart';

class WriteReviewScreen extends StatefulWidget {
  final UserBookingData booking;

  const WriteReviewScreen({super.key, required this.booking});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final MyBookingsController _controller = Get.find<MyBookingsController>();
  final TextEditingController _reviewTextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  double _rating = 5.0;
  final List<String> _selectedImages = [];
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (_selectedImages.length < 5) {
        File originalFile = File(image.path);
        // Compress to 555 KB (555 * 1024 bytes)
        File compressedFile = await CommonConstant.instance
            .compressImage(originalFile, 555 * 1024);

        setState(() {
          _selectedImages.add(compressedFile.path);
        });
      } else {
        Get.snackbar("Limit Reached", "You can only add up to 5 photos.");
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _submitReview() async {
    if (_reviewTextController.text.trim().isEmpty) {
      Get.snackbar("Review Required", "Please write a review.");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    bool success = await _controller.submitReview(
      bookingId: widget.booking.id!,
      rating: _rating,
      reviewText: _reviewTextController.text,
      imagePaths: _selectedImages,
    );

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Write a Review",
          style:
              PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: textColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cafe Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomImageView(
                      url: widget.booking.cafe!.image!.startsWith('/')
                          ? "${ApiEndPoints.imageBaseUrl}" +
                              widget.booking.cafe!.image!
                          : widget.booking.cafe!.image!,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.booking.cafe?.name ?? "N/A",
                          style: PMT.style(16,
                              fontColor: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.booking.cafe?.address ?? "N/A",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: PMT.style(12, fontColor: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            Center(
              child: Text(
                "How was your experience?",
                style: PMT.style(18,
                    fontColor: textColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Rating Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      index < _rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: ColorConstant.primaryColor,
                      size: 40,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // Review Text
            Text(
              "Your Review",
              style: PMT.style(14,
                  fontColor: textColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: TextField(
                controller: _reviewTextController,
                maxLines: 5,
                style: PMT.style(14, fontColor: textColor),
                decoration: InputDecoration(
                  hintText: "Share your experience...",
                  hintStyle: PMT.style(14, fontColor: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              "Add Photos",
              style: PMT.style(14,
                  fontColor: textColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Photos List
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined,
                              color: isDark ? Colors.white70 : Colors.black54),
                          const SizedBox(height: 4),
                          Text("Add",
                              style: PMT.style(12,
                                  fontColor: isDark
                                      ? Colors.white70
                                      : Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ..._selectedImages.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(entry.value),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -8,
                            right: -8,
                            child: GestureDetector(
                              onTap: () => _removeImage(entry.key),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close,
                                    size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.black))
                    : Text(
                        "Submit Review",
                        style: PMT.style(16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
