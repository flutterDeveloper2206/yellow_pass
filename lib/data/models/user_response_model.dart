
class UserResponse {
  bool? status;
  int? statusCode;
  String? message;
  Data? data;

  UserResponse({this.status, this.statusCode, this.message, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = (json['data'] != null && json['data'] is Map<String, dynamic>) 
        ? Data.fromJson(json['data']) 
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

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
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
  String? totalTokensSpent;
  String? totalTokensPurchased;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
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
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    referralCode = json['referral_code'];
    isPublic = json['is_public'] is bool ? json['is_public'] : (json['is_public'] == 1);
    referrerId = json['referrer_id'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    linkedinId = json['linkedin_id'];
    isEmailVerified = json['is_email_verified'] is bool ? json['is_email_verified'] : (json['is_email_verified'] == 1);
    isMobileVerified = json['is_mobile_verified'] is bool ? json['is_mobile_verified'] : (json['is_mobile_verified'] == 1);
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
    return data;
  }
}
