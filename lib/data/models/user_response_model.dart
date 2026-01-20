class UserResponse {
  bool? status;
  int? statusCode;
  String? message;
  User? data;

  UserResponse({this.status, this.statusCode, this.message, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = (json['data'] != null && json['data'] is Map<String, dynamic>)
        ? User.fromJson(json['data'])
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

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? referralCode;
  bool? isPublic;
  int? referrerId;
  String? emailVerifiedAt;
  String? role;
  String? linkedinId;
  bool? isEmailVerified;
  bool? isMobileVerified;
  String? profilePicture;
  String? expiresIn;
  String? description;
  dynamic walletBalance;
  dynamic totalTokensSpent;
  dynamic totalTokensPurchased;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  ActiveSubscription? activeSubscription;

  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.referralCode,
    this.isPublic,
    this.referrerId,
    this.emailVerifiedAt,
    this.role,
    this.linkedinId,
    this.isEmailVerified,
    this.isMobileVerified,
    this.profilePicture,
    this.expiresIn,
    this.description,
    this.walletBalance,
    this.totalTokensSpent,
    this.totalTokensPurchased,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.activeSubscription,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    referralCode = json['referral_code'];
    isPublic = json['is_public'] is bool
        ? json['is_public']
        : (json['is_public'] == 1);
    referrerId = json['referrer_id'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    linkedinId = json['linkedin_id'];
    isEmailVerified = json['is_email_verified'] is bool
        ? json['is_email_verified']
        : (json['is_email_verified'] == 1);
    isMobileVerified = json['is_mobile_verified'] is bool
        ? json['is_mobile_verified']
        : (json['is_mobile_verified'] == 1);
    profilePicture = json['profile_picture'];
    expiresIn = json['expires_in'];
    description = json['description'];
    walletBalance = json['wallet_balance'];
    totalTokensSpent = json['total_tokens_spent'];
    totalTokensPurchased = json['total_tokens_purchased'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    activeSubscription = json['active_subscription'] != null
        ? ActiveSubscription.fromJson(json['active_subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['referral_code'] = referralCode;
    data['is_public'] = isPublic;
    data['referrer_id'] = referrerId;
    data['email_verified_at'] = emailVerifiedAt;
    data['role'] = role;
    data['linkedin_id'] = linkedinId;
    data['is_email_verified'] = isEmailVerified;
    data['is_mobile_verified'] = isMobileVerified;
    data['profile_picture'] = profilePicture;
    data['expires_in'] = expiresIn;
    data['description'] = description;
    data['wallet_balance'] = walletBalance;
    data['total_tokens_spent'] = totalTokensSpent;
    data['total_tokens_purchased'] = totalTokensPurchased;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (activeSubscription != null) {
      data['active_subscription'] = activeSubscription!.toJson();
    }
    return data;
  }
}

class ActiveSubscription {
  int? id;
  int? userId;
  int? subscriptionId;
  String? startDate;
  String? endDate;
  String? status;
  String? paymentId;
  String? orderId;
  String? createdAt;
  String? updatedAt;
  SubscriptionInner? subscription;

  ActiveSubscription({
    this.id,
    this.userId,
    this.subscriptionId,
    this.startDate,
    this.endDate,
    this.status,
    this.paymentId,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.subscription,
  });

  ActiveSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subscriptionId = json['subscription_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    paymentId = json['payment_id'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subscription = json['subscription'] != null
        ? SubscriptionInner.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['subscription_id'] = subscriptionId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['payment_id'] = paymentId;
    data['order_id'] = orderId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    return data;
  }
}

class SubscriptionInner {
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

  SubscriptionInner({
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

  SubscriptionInner.fromJson(Map<String, dynamic> json) {
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
