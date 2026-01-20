import 'package:get/get.dart';
import '../../../data/models/order_list_response_model.dart';
import '../../../widgets/common_snackbar.dart';
import '../repository/my_orders_repository.dart';

class MyOrdersController extends GetxController {
  final MyOrdersRepository _repository = Get.find<MyOrdersRepository>();

  final RxList<OrderData> orders = <OrderData>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final response = await _repository.getOrders();
      if (response != null && response['status'] == true) {
        final orderListResponse = OrderListResponseModel.fromJson(response);
        orders.value = orderListResponse.data ?? [];
      } else {
        CommonSnackbar.showError(
          message: response?['message'] ?? "Failed to fetch orders",
        );
      }
    } catch (e) {
      print("Error fetching orders: $e");
      CommonSnackbar.showError(
          message: "Something went wrong while fetching orders");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      final response = await _repository.cancelOrder(orderId);
      if (response != null && response['status'] == true) {
        CommonSnackbar.showSuccess(
          message: response['message'] ?? "Order cancelled successfully!",
        );
        // Refresh orders list
        fetchOrders();
      } else {
        CommonSnackbar.showError(
          message: response?['message'] ?? "Failed to cancel order",
        );
      }
    } catch (e) {
      print("Error cancelling order: $e");
      CommonSnackbar.showError(
          message: "Something went wrong while cancelling order");
    }
  }
}
