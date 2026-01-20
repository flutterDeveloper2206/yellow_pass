import 'package:get/get.dart';
import 'package:yellow_pass/data/models/cafe_response_model.dart';
import 'package:yellow_pass/widgets/common_snackbar.dart';
import '../repository/menu_repository.dart';

class MenuController extends GetxController {
  final MenuRepository _repository = Get.find<MenuRepository>();
  final Rx<Cafe?> cafe = Rx<Cafe?>(null);
  final RxList<MenuItem> menuItems = <MenuItem>[].obs;
  final RxMap<String, int> itemQuantities = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Cafe) {
      cafe.value = Get.arguments as Cafe;
      menuItems.value = cafe.value?.menuItems ?? [];
      // Initialize quantities
      for (var item in menuItems) {
        if (item.id != null) {
          itemQuantities[item.id!] = 0;
        }
      }
    }
  }

  void incrementQuantity(String itemId) {
    int current = itemQuantities[itemId] ?? 0;
    itemQuantities[itemId] = current + 1;
    itemQuantities.refresh();
  }

  void decrementQuantity(String itemId) {
    int current = itemQuantities[itemId] ?? 0;
    if (current > 0) {
      itemQuantities[itemId] = current - 1;
      itemQuantities.refresh();
    }
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in menuItems) {
      if (item.id != null) {
        int qty = itemQuantities[item.id!] ?? 0;
        double price = double.tryParse(item.price ?? "0.0") ?? 0.0;
        total += (price * qty);
      }
    }
    return total;
  }

  bool get hasItemsInCart => itemQuantities.values.any((qty) => qty > 0);

  Future<void> placeOrder() async {
    final cafeId = cafe.value?.id;
    if (cafeId == null) {
      CommonSnackbar.showError(message: "Invalid cafe information");
      return;
    }

    final selectedItems = <Map<String, dynamic>>[];
    itemQuantities.forEach((id, qty) {
      if (qty > 0) {
        selectedItems.add({
          "menu_item_id": id,
          "quantity": qty,
        });
      }
    });

    if (selectedItems.isEmpty) {
      CommonSnackbar.showError(message: "Please select at least one item");
      return;
    }

    final orderData = {
      "cafe_id": cafeId,
      "items": selectedItems,
    };

    try {
      final response = await _repository.placeOrder(orderData);

      if (response != null && response['status'] == true) {
        CommonSnackbar.showSuccess(
          message: response['message'] ?? "Order placed successfully!",
        );
        // Clear cart after successful order
        itemQuantities.forEach((key, value) {
          itemQuantities[key] = 0;
        });
        itemQuantities.refresh();
        Get.back(); // Go back to cafe details or stay on screen as per requirement
      } else {
        CommonSnackbar.showError(
          message: response?['message'] ?? "Failed to place order",
        );
      }
    } catch (e) {
      print("Error placing order: $e");
      CommonSnackbar.showError(
        message: "Something went wrong while placing order",
      );
    }
  }
}
