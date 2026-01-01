import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:yellow_pass/presentation/wallet_screen/repository/wallet_repository.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';

class RazorpayService {
  final Razorpay _razorpay = Razorpay();
  final WalletRepository _repository = Get.find<WalletRepository>();

  void initialize({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout(Map<String, dynamic> data) {
    var options = {
      'key': data['key_id'] ?? '',
      'amount': data['amount_paise'] ?? 0.0, // in paise
      'name': data['name'] ?? '',
      'description': data['description'] ?? '',
      'order_id': data['order_id'] ?? '',
      'prefill': data['prefill'] ?? {},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      CommonSnackbar.showError(message: "Failed to open payment gateway");
    }
  }

  Future<bool> verifyPayment(Map<String, dynamic> data) async {
    try {
      var response = await _repository.verifyTokens(data);
      if (response != null && response['status'] == true) {
        return true;
      } else {
        CommonSnackbar.showError(
            message: response?['message'] ?? "Payment Verification Failed");
        return false;
      }
    } catch (e) {
      print("Error verify payment: $e");
      CommonSnackbar.showError(
          message: "Something went wrong during verification");
      return false;
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
