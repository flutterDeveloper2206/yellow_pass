import 'package:get/get.dart';

class Transaction {
  final String title;
  final String date;
  final String type; // 'credited' or 'debited'
  final String icon;

  Transaction({
    required this.title,
    required this.date,
    required this.type,
    required this.icon,
  });
}

class WalletHistoryController extends GetxController {
  final RxString selectedMonth = 'Aug 2025'.obs;
  
  final List<String> months = [
    'Aug 2025',
    'Jul 2025',
    'Jun 2025',
    'May 2025',
    'Apr 2025',
  ];

  final RxList<Transaction> transactions = <Transaction>[
    Transaction(
      title: 'Wallet Recharge',
      date: '12 Aug 2025, 12:00 pm',
      type: 'credited',
      icon: 'wallet',
    ),
    Transaction(
      title: 'Booking',
      date: '12 Aug 2025, 10:00 pm',
      type: 'debited',
      icon: 'booking',
    ),
    Transaction(
      title: 'Booking',
      date: '12 Aug 2025, 10:00 pm',
      type: 'debited',
      icon: 'booking',
    ),
    Transaction(
      title: 'Wallet Recharge',
      date: '12 Aug 2025, 10:00 pm',
      type: 'credited',
      icon: 'wallet',
    ),
  ].obs;

  void changeMonth(String month) {
    selectedMonth.value = month;
    // Here you can add logic to fetch transactions for the selected month
  }
}
