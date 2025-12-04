import 'package:get/get.dart';
import '../controller/wallet_history_controller.dart';

class WalletHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletHistoryController());
  }
}
