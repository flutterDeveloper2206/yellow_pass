class SubscriptionInitiateResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  SubscriptionInitiateData? data;

  SubscriptionInitiateResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  SubscriptionInitiateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null
        ? SubscriptionInitiateData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubscriptionInitiateData {
  String? orderId;
  String? keyId;
  int? amountPaise;
  String? currency;
  String? name;
  String? description;
  Prefill? prefill;

  SubscriptionInitiateData({
    this.orderId,
    this.keyId,
    this.amountPaise,
    this.currency,
    this.name,
    this.description,
    this.prefill,
  });

  SubscriptionInitiateData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    keyId = json['key_id'];
    amountPaise = json['amount_paise'];
    currency = json['currency'];
    name = json['name'];
    description = json['description'];
    prefill =
        json['prefill'] != null ? Prefill.fromJson(json['prefill']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['key_id'] = keyId;
    data['amount_paise'] = amountPaise;
    data['currency'] = currency;
    data['name'] = name;
    data['description'] = description;
    if (prefill != null) {
      data['prefill'] = prefill!.toJson();
    }
    return data;
  }
}

class Prefill {
  String? name;
  String? email;
  String? contact;

  Prefill({this.name, this.email, this.contact});

  Prefill.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['contact'] = contact;
    return data;
  }
}
