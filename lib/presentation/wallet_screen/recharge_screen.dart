import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/presentation/wallet_screen/controller/wallet_screen_controller.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';

class RechargeScreen extends GetWidget<WalletScreenController> {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is found if navigated to without binding or if parent has it
    // Usually GetWidget relies on Get.find() which works if controller is already in memory
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final cardColor = isDarkMode ? const Color(0xFF2C2C2C) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "Recharge",
          style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: textColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDarkMode ? [] : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.monetization_on, color: Colors.orange, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Balance",
                          style: PMT.style(12, fontColor: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                          "${controller.balance.value} Token",
                          style: PMT.style(24, fontColor: textColor, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              Text(
                "Recharge",
                style: PMT.style(14, fontColor: textColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              // Custom Amount Input
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text("₹", style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.amountController,
                        keyboardType: TextInputType.number,
                        style: PMT.style(18, fontColor: textColor, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                  "( ₹${controller.displayAmount.value} = ${controller.displayAmount.value} Token)",
                  style: PMT.style(12, fontColor: Colors.grey),
              )),
              
              const SizedBox(height: 24),
              
              // Preset Chips
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: controller.presetAmounts.map((amount) {
                  return Obx(() {
                    bool isSelected = controller.selectedAmount.value == amount;
                    return GestureDetector(
                      onTap: () => controller.selectAmount(amount),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? (isDarkMode ? Colors.yellow.withOpacity(0.1) : Colors.yellow.withOpacity(0.1)) 
                              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? Colors.orange : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          "₹$amount",
                          style: PMT.style(
                            16, 
                            fontColor: isSelected ? Colors.orange : (isDarkMode ? Colors.grey : Colors.black54),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
              
              const SizedBox(height: 40),
              
              // Recharge Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.initiateRecharge(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    foregroundColor: isDarkMode ? Colors.black : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: Text(
                    "Recharge Now",
                    style: PMT.style(
                      16, 
                      fontColor: isDarkMode ? Colors.black : Colors.white, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
