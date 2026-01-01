class TransactionHistoryResponse {
  bool? status;
  int? statusCode;
  String? message;
  TransactionHistoryData? data;

  TransactionHistoryResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      status: json['status'],
      statusCode: json['status_code'],
      message: json['message'],
      data: json['data'] != null
          ? TransactionHistoryData.fromJson(json['data'])
          : null,
    );
  }
}

class TransactionHistoryData {
  int? walletBalance;
  int? totalTokensSpent;
  int? totalTokensPurchased;
  List<Transaction>? transactions;

  TransactionHistoryData({
    this.walletBalance,
    this.totalTokensSpent,
    this.totalTokensPurchased,
    this.transactions,
  });

  factory TransactionHistoryData.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryData(
      walletBalance: json['wallet_balance'],
      totalTokensSpent: json['total_tokens_spent'],
      totalTokensPurchased: json['total_tokens_purchased'],
      transactions: json['transactions'] != null
          ? (json['transactions'] as List)
              .map((e) => Transaction.fromJson(e))
              .toList()
          : null,
    );
  }
}

class Transaction {
  int? id;
  int? userId;
  int? cafeId;
  String? type;
  int? amount;
  int? paymentId;
  String? bookingId;
  String? transactionId;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Transaction({
    this.id,
    this.userId,
    this.cafeId,
    this.type,
    this.amount,
    this.paymentId,
    this.bookingId,
    this.transactionId,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      cafeId: json['cafe_id'],
      type: json['type'],
      amount: json['amount'],
      paymentId: json['payment_id'],
      bookingId: json['booking_id'],
      transactionId: json['transaction_id'],
      description: json['description'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
