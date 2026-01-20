class SubscriptionResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<SubscriptionData>? data;

  SubscriptionResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubscriptionData>[];
      json['data'].forEach((v) {
        data!.add(SubscriptionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionData {
  int? id;
  String? name;
  String? price;
  int? durationDays;
  int? discountPercentage;
  int? bonusTokens;
  String? description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  SubscriptionData({
    this.id,
    this.name,
    this.price,
    this.durationDays,
    this.discountPercentage,
    this.bonusTokens,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    durationDays = json['duration_days'];
    discountPercentage = json['discount_percentage'];
    bonusTokens = json['bonus_tokens'];
    description = json['description'];
    isActive =
        json['is_active'] is int ? json['is_active'] == 1 : json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['duration_days'] = durationDays;
    data['discount_percentage'] = discountPercentage;
    data['bonus_tokens'] = bonusTokens;
    data['description'] = description;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
