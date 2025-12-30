import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/controller/cafe_book_controller.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';
import 'package:yellow_pass/data/models/table_type_response_model.dart';
import 'package:intl/intl.dart';

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
                _buildTableSize(context),
                const SizedBox(height: 20),

                _buildDurationSlider(context),
                const SizedBox(height: 20),
                _buildTimeSlots(context),


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
            Obx(() => Text(
              controller.dateObjects.isEmpty ? "" :
              controller.formatMonthYear(controller.dateObjects[controller.selectedDateIndex.value]), 
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            )),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: Obx(() => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.dateObjects.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final date = controller.dateObjects[index];
                    return Obx(
                      () =>  GestureDetector(
                        onTap: () => controller.selectDate(index),
                        child: Container(
                          width: 60,
                          decoration: BoxDecoration(
                            color: controller.selectedDateIndex.value == index
                                ? (isDarkMode ? Colors.yellow : const Color(0xFFFFF3E0))
                                : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: controller.selectedDateIndex.value == index
                                  ? (isDarkMode ? Colors.yellow : Colors.yellow)
                                  : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                              width: controller.selectedDateIndex.value == index ? 2 : 1,
                            ),
                            boxShadow: [
                              if (!(controller.selectedDateIndex.value == index) && !isDarkMode)
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
                                controller.formatDayValue(date),
                                style: TextStyle(
                                  color: controller.selectedDateIndex.value == index
                                      ? Colors.black
                                      : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.formatDateValue(date),
                                style: TextStyle(
                                  color: controller.selectedDateIndex.value == index
                                      ? Colors.black
                                      : (isDarkMode ? Colors.white : Colors.black),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => controller.pickDate(context),
                child: Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Other",
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
        Obx(() {
          if (controller.isSlotsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.timeSlots.isEmpty) {
            return Text(
              "No slots available for this selection.",
              style: TextStyle(color: Colors.red.shade400),
            );
          }
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(controller.timeSlots.length, (index) {
              final isSelected = controller.selectedTimeSlotIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectTimeSlot(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? (isDarkMode ? Colors.yellow : const Color(0xFFFFF3E0)) 
                        : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? (isDarkMode ? Colors.yellow : Colors.yellow)
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
            }),
          );
        }),
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
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(controller.tableTypes.length, (index) {
              final table = controller.tableTypes[index];
              final isSelected = controller.selectedTableTypeIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectTableType(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? (isDarkMode ? Colors.yellow : const Color(0xFFFFF3E0)) 
                        : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? (isDarkMode ? Colors.yellow : Colors.yellow)
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
                    table.name ?? "",
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.black 
                          : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                )
              );
            }),
          );
        }),
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
            thumbColor: Colors.yellow,
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
      child: Obx(() {
        final isEnabled = controller.selectedTimeSlotIndex.value != -1;
        return ElevatedButton(
          onPressed: isEnabled ? () {
            // Implement booking confirmation logic
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled 
                ? (isDarkMode ? Colors.white : Colors.black)
                : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Text(
            "Proceed to Pay",
            style: TextStyle(
              color: isEnabled 
                  ? (isDarkMode ? Colors.black : Colors.white)
                  : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }
}
