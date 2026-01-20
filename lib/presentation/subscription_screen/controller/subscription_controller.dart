import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../repository/subscription_repository.dart';
import '../../../data/models/subscription_response_model.dart';
import '../../../data/models/subscription_initiate_response_model.dart';
import '../../../data/models/user_response_model.dart';
import '../../../core/utils/shared_prefs.dart';
import '../../../presentation/dashboard_screen/repository/dashboard_repository.dart';
import '../../../widgets/common_snackbar.dart';

class SubscriptionController extends GetxController {
  final SubscriptionRepository _repository = SubscriptionRepository();
  final Razorpay _razorpay = Razorpay();

  final RxList<SubscriptionData> subscriptions = <SubscriptionData>[].obs;
  final Rx<ActiveSubscription?> activeSubscription =
      Rx<ActiveSubscription?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    loadActiveSubscriptionFromPrefs();
    fetchSubscriptions();
  }

  void loadActiveSubscriptionFromPrefs() {
    final userData = SharedPrefs.getUser();
    if (userData != null && userData['active_subscription'] != null) {
      activeSubscription.value =
          ActiveSubscription.fromJson(userData['active_subscription']);
    }
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  Future<void> fetchSubscriptions() async {
    try {
      isLoading.value = true;
      final response = await _repository.getSubscriptions();
      if (response != null && response['status'] == true) {
        final subscriptionResponse =
            SubscriptionResponseModel.fromJson(response);
        subscriptions.value = subscriptionResponse.data ?? [];
      } else {
        CommonSnackbar.showError(
          message: response?['message'] ?? "Failed to fetch subscriptions",
        );
      }
    } catch (e) {
      print("Error fetching subscriptions: $e");
      CommonSnackbar.showError(
          message: "Something went wrong while fetching subscriptions");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> buySubscription(int id) async {
    try {
      final response = await _repository.initiateSubscription(id);
      if (response != null && response['status'] == true) {
        final initiateResponse =
            SubscriptionInitiateResponseModel.fromJson(response);
        if (initiateResponse.data != null) {
          _openCheckout(initiateResponse.data!);
        }
      } else {
        CommonSnackbar.showError(
          message: response?['message'] ?? "Failed to initiate subscription",
        );
      }
    } catch (e) {
      print("Error initiating subscription: $e");
      CommonSnackbar.showError(
          message: "Something went wrong while initiating subscription");
    }
  }

  void _openCheckout(SubscriptionInitiateData data) {
    var options = {
      'key': data.keyId ?? '',
      'amount': data.amountPaise ?? 0,
      'name': data.name ?? 'YellowPass',
      'description': data.description ?? '',
      'order_id': data.orderId ?? '',
      'prefill': {
        'name': data.prefill?.name ?? '',
        'email': data.prefill?.email ?? '',
        'contact': data.prefill?.contact ?? '',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
      CommonSnackbar.showError(message: "Could not open payment gateway");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final verifyData = {
      "razorpay_order_id": response.orderId,
      "razorpay_payment_id": response.paymentId,
      "razorpay_signature": response.signature
    };

    try {
      final verifyResponse = await _repository.verifySubscription(verifyData);
      if (verifyResponse != null && verifyResponse['status'] == true) {
        CommonSnackbar.showSuccess(
          message: verifyResponse['message'] ?? "Subscription successful!",
        );

        // Refresh profile to get the new active subscription
        await refreshUserProfile();

        Get.back(); // Go back to profile
      } else {
        CommonSnackbar.showError(
          message: verifyResponse?['message'] ?? "Verification failed",
        );
      }
    } catch (e) {
      print("Error verifying subscription: $e");
      CommonSnackbar.showError(
          message: "Something went wrong during verification");
    }
  }

  Future<void> refreshUserProfile() async {
    try {
      final dashboardRepo = Get.put(DashboardRepository());
      final response = await dashboardRepo.getUserProfile();
      if (response != null && response['status'] == true) {
        if (response['data'] != null) {
          await SharedPrefs.setUser(response['data']);
          loadActiveSubscriptionFromPrefs();
        }
      }
    } catch (e) {
      print("Error refreshing profile: $e");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CommonSnackbar.showError(
      message: response.message ?? "Payment failed",
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CommonSnackbar.showWarning(
      message: "External wallet selected: ${response.walletName}",
    );
  }
}
