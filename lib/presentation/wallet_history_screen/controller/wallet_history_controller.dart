import 'package:get/get.dart';
import 'package:yellow_pass/presentation/wallet_screen/repository/wallet_repository.dart';
import 'package:yellow_pass/data/models/transaction_history_response_model.dart';

class WalletHistoryController extends GetxController {
  final WalletRepository _repository = Get.find<WalletRepository>();
  
  final RxBool isLoading = false.obs;
  final RxInt walletBalance = 0.obs;
  final RxInt totalTokensSpent = 0.obs;
  final RxInt totalTokensPurchased = 0.obs;
  final RxList<Transaction> transactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactionHistory();
  }

  Future<void> fetchTransactionHistory() async {
    try {
      isLoading.value = true;
      
      var response = await _repository.getTransactionHistory();
      
      if (response != null && response['status'] == true) {
        TransactionHistoryResponse historyResponse = 
            TransactionHistoryResponse.fromJson(response);
        
        if (historyResponse.data != null) {
          walletBalance.value = historyResponse.data!.walletBalance ?? 0;
          totalTokensSpent.value = historyResponse.data!.totalTokensSpent ?? 0;
          totalTokensPurchased.value = historyResponse.data!.totalTokensPurchased ?? 0;
          
          if (historyResponse.data!.transactions != null) {
            transactions.value = historyResponse.data!.transactions!;
          }
        }
      }
    } catch (e) {
      print("Error fetching transaction history: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
