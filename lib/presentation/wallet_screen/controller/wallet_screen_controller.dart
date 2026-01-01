import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:yellow_pass/presentation/wallet_screen/repository/wallet_repository.dart';
import 'package:yellow_pass/presentation/wallet_screen/services/razorpay_service.dart';
import 'package:yellow_pass/presentation/wallet_screen/recharge_result_screen.dart';
import 'package:yellow_pass/presentation/dashboard_screen/repository/dashboard_repository.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';
import 'package:yellow_pass/core/utils/shared_prefs.dart';

class WalletScreenController extends GetxController {
  final WalletRepository _repository = Get.put(WalletRepository());
  final RazorpayService _razorpayService = RazorpayService();
  final DashboardRepository _dashboardRepository = Get.find<DashboardRepository>();

  final RxInt balance = 0.obs;
  final RxInt selectedAmount = 0.obs;
  final RxInt displayAmount = 0.obs;
  final RxBool isLoading = false.obs;
  final TextEditingController amountController = TextEditingController();

  final List<int> presetAmounts = [100, 150, 200, 250, 500, 1000];
  
  String? _currentOrderId;
  int? _currentAmount;

  @override
  void onInit() {
    super.onInit();
    
    _razorpayService.initialize(
      onSuccess: _handlePaymentSuccess,
      onError: _handlePaymentError,
      onExternalWallet: _handleExternalWallet,
    );
    
    amountController.addListener(() {
      if (amountController.text.isNotEmpty) {
        int? val = int.tryParse(amountController.text);
        if (val != null) {
          displayAmount.value = val;
          if (!presetAmounts.contains(val)) {
            selectedAmount.value = 0;
          } else {
            selectedAmount.value = val;
          }
        } else {
          displayAmount.value = 0;
        }
      } else {
        displayAmount.value = 0;
        selectedAmount.value = 0;
      }
    });
    
    // Fetch user profile to get balance
    fetchUserBalance();
  }

  @override
  void onClose() {
    _razorpayService.dispose();
    amountController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    // Refresh balance when screen becomes active
    fetchUserBalance();
  }

  void selectAmount(int amount) {
    selectedAmount.value = amount;
    amountController.text = amount.toString();
  }

  Future<void> initiateRecharge() async {
    int? amount = int.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      CommonSnackbar.showError(message: "Please enter a valid amount");
      return;
    }

    try {
      var response = await _repository.buyTokens(amount);
      if (response != null && response['status'] == true) {
        var data = response['data'];
        _currentOrderId = data['order_id'];
        _currentAmount = amount;
        _razorpayService.openCheckout(data);
      } else {
        CommonSnackbar.showError(
            message: response?['message'] ?? "Failed to initiate recharge");
      }
    } catch (e) {
      print("Error initiating recharge: $e");
      CommonSnackbar.showError(message: "Something went wrong");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    bool verified = await _razorpayService.verifyPayment({
      "razorpay_order_id": response.orderId,
      "razorpay_payment_id": response.paymentId,
      "razorpay_signature": response.signature
    });

    if (verified) {
      // Refresh balance after successful payment
      await fetchUserBalance();
      
      Get.to(() => RechargeResultScreen(
        isSuccess: true,
        amount: _currentAmount?.toString() ?? "0",
        tokens: _currentAmount?.toString() ?? "0",
      ));
    } else {
      Get.to(() => const RechargeResultScreen(
        isSuccess: false,
        errorMessage: "Payment verification failed. Please contact support.",
      ));
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.to(() => RechargeResultScreen(
      isSuccess: false,
      errorMessage: response.message ?? "Payment failed. Please try again.",
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CommonSnackbar.showError(
        message: "External Wallet Selected: ${response.walletName}");
  }

  Future<void> fetchUserBalance() async {
    try {
      isLoading.value = true;
      
      // First try to get from SharedPrefs
      final userData = SharedPrefs.getUser();
      if (userData != null && userData['wallet_balance'] != null) {
        balance.value = userData['wallet_balance'] is int
            ? userData['wallet_balance']
            : int.tryParse(userData['wallet_balance'].toString()) ?? 0;
      }
      
      // Then fetch fresh data from API
      final response = await _dashboardRepository.getUserProfile();
      if (response != null && response['status'] == true) {
        if (response['data'] != null) {
          await SharedPrefs.setUser(response['data']);
          
          // Update balance from API response
          if (response['data']['wallet_balance'] != null) {
            balance.value = response['data']['wallet_balance'] is int
                ? response['data']['wallet_balance']
                : int.tryParse(response['data']['wallet_balance'].toString()) ?? 0;
          }
        }
      }
    } catch (e) {
      print("Error fetching user balance: $e");
      // If API fails, keep the balance from SharedPrefs
    } finally {
      isLoading.value = false;
    }
  }
}

