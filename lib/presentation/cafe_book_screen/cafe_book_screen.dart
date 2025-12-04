import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/controller/cafe_book_controller.dart';

class CafeBookScreen extends GetView<CafeBookController> {
  const CafeBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text("Book Cafe", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateSelection(context),
                const SizedBox(height: 20),
                _buildTimeSlots(context),
                const SizedBox(height: 20),
                _buildTableSize(context),
                const SizedBox(height: 20),
                _buildDurationSlider(context),
                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: _buildBottomButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Choose Date", 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              "Oct, 2025", 
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.dates.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return Obx(() {
                final isSelected = controller.selectedDateIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.selectDate(index),
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (isDarkMode ? Colors.yellow.shade700 : const Color(0xFFFFF3E0)) 
                          : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected 
                            ? (isDarkMode ? Colors.yellow.shade700 : Colors.orange) 
                            : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        if (!isSelected && !isDarkMode)
                          BoxShadow(
                            color: theme.shadowColor.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                        controller.days[index],
                        style: TextStyle(
                          color: isSelected 
                              ? Colors.black 
                              : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.dates[index],
                        style: TextStyle(
                          color: isSelected 
                              ? Colors.black 
                              : (isDarkMode ? Colors.white : Colors.black),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlots(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Time slots", 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(controller.timeSlots.length, (index) {
            return Obx(() {
              final isSelected = controller.selectedTimeSlotIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectTimeSlot(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? (isDarkMode ? Colors.yellow.shade700 : const Color(0xFFFFF3E0)) 
                        : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? (isDarkMode ? Colors.yellow.shade700 : Colors.orange) 
                          : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                    ),
                    boxShadow: [
                      if (!isDarkMode)
                        BoxShadow(
                          color: theme.shadowColor.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Text(
                    controller.timeSlots[index],
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.black 
                          : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                )
              );
            });
          }),
        ),
      ],
    );
  }

  Widget _buildTableSize(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Table Size", 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(controller.tableSizes.length, (index) {
            return Obx(() {
              final isSelected = controller.selectedTableSizeIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectTableSize(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? (isDarkMode ? Colors.yellow.shade700 : const Color(0xFFFFF3E0)) 
                        : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? (isDarkMode ? Colors.yellow.shade700 : Colors.orange) 
                          : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                    ),
                    boxShadow: [
                      if (!isDarkMode)
                        BoxShadow(
                          color: theme.shadowColor.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Text(
                    controller.tableSizes[index],
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.black 
                          : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                )
              );
            });
          }),
        ),
      ],
    );
  }

  Widget _buildDurationSlider(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time Duration", 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() => SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: theme.colorScheme.outlineVariant,
            inactiveTrackColor: theme.colorScheme.outlineVariant,
            thumbColor: Colors.yellow.shade700,
            overlayColor: Colors.yellow.withOpacity(0.2),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8, elevation: 2),
          ),
          child: Slider(
            value: controller.duration.value,
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (value) => controller.updateDuration(value),
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Min: 1hr", 
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              "Max: 5hrs", 
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Implement booking confirmation logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          "Proceed to Pay",
          style: TextStyle(
            color: isDarkMode ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
