import 'user_response_model.dart';

class CafeResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<Cafe>? data;

  CafeResponse({this.status, this.statusCode, this.message, this.data});

  CafeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Cafe>[];
      json['data'].forEach((v) {
        data!.add(Cafe.fromJson(v));
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

class Cafe {
  String? id;
  int? ownerId;
  String? name;
  String? category;
  String? description;
  String? address;
  String? city;
  String? latitude;
  String? longitude;
  List<String>? photos;
  List<String>? amenities;
  String? openTime;
  String? closeTime;
  String? contactPhone;
  String? contactEmail;
  String? status;
  String? rating;
  int? reviewCount;
  int? walletBalance;
  dynamic totalTokensEarned;
  String? createdAt;
  String? updatedAt;
  int? totalSeats;
  String? pricePerHour;
  User? owner;
  List<CafeTable>? tables;
  List<Review>? reviews;
  dynamic averageRating;
  int? totalReviews;
  List<String>? timings;
  List<dynamic>? menuItems;
  List<Ads>? ads;

  Cafe(
      {this.id,
      this.ownerId,
      this.name,
      this.category,
      this.description,
      this.address,
      this.city,
      this.latitude,
      this.longitude,
      this.photos,
      this.amenities,
      this.openTime,
      this.closeTime,
      this.contactPhone,
      this.contactEmail,
      this.status,
      this.rating,
      this.reviewCount,
      this.walletBalance,
      this.totalTokensEarned,
      this.createdAt,
      this.updatedAt,
      this.totalSeats,
      this.pricePerHour,
      this.owner,
      this.tables,
      this.reviews,
      this.averageRating,
      this.totalReviews,
      this.timings,
      this.menuItems,
      this.ads});

  Cafe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    photos = json['photos']?.cast<String>();
    amenities = json['amenities']?.cast<String>();
    openTime = json['open_time'];
    closeTime = json['close_time'];
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
    status = json['status'];
    rating = json['rating']?.toString();
    reviewCount = json['review_count'];
    walletBalance = json['wallet_balance'];
    totalTokensEarned = json['total_tokens_earned'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalSeats = json['total_seats'];
    pricePerHour = json['price_per_hour'];
    averageRating = json['average_rating'];
    totalReviews = json['total_reviews'];
    timings = json['timings']?.cast<String>();
    menuItems = json['menu_items'];
    owner = json['owner'] != null ? User.fromJson(json['owner']) : null;
    if (json['tables'] != null) {
      tables = <CafeTable>[];
      json['tables'].forEach((v) {
        tables!.add(CafeTable.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['address'] = address;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['photos'] = photos;
    data['amenities'] = amenities;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['contact_phone'] = contactPhone;
    data['contact_email'] = contactEmail;
    data['status'] = status;
    data['rating'] = rating;
    data['review_count'] = reviewCount;
    data['wallet_balance'] = walletBalance;
    data['total_tokens_earned'] = totalTokensEarned;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_seats'] = totalSeats;
    data['price_per_hour'] = pricePerHour;
    data['average_rating'] = averageRating;
    data['total_reviews'] = totalReviews;
    data['timings'] = timings;
    data['menu_items'] = menuItems;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (tables != null) {
      data['tables'] = tables!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (ads != null) {
      data['ads'] = ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CafeTable {
  String? id;
  String? cafeId;
  String? tableTypeId;
  String? name;
  String? tableNumber;
  String? tableType;
  int? capacity;
  bool? isActive;
  String? hourlyRate;
  String? status;
  String? createdAt;
  String? updatedAt;

  CafeTable(
      {this.id,
      this.cafeId,
      this.tableTypeId,
      this.name,
      this.tableNumber,
      this.tableType,
      this.capacity,
      this.isActive,
      this.hourlyRate,
      this.status,
      this.createdAt,
      this.updatedAt});

  CafeTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cafeId = json['cafe_id'];
    tableTypeId = json['table_type_id'];
    name = json['name'];
    tableNumber = json['table_number'];
    tableType = json['table_type'];
    capacity = json['capacity'];
    isActive = json['is_active'];
    hourlyRate = json['hourly_rate'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cafe_id'] = cafeId;
    data['table_type_id'] = tableTypeId;
    data['name'] = name;
    data['table_number'] = tableNumber;
    data['table_type'] = tableType;
    data['capacity'] = capacity;
    data['is_active'] = isActive;
    data['hourly_rate'] = hourlyRate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Review {
  String? id;
  int? userId;
  String? cafeId;
  String? bookingId;
  int? rating;
  String? reviewText;
  String? status;
  List<String>? photos;
  String? createdAt;
  String? updatedAt;
  ReviewUser? user;

  Review(
      {this.id,
      this.userId,
      this.cafeId,
      this.bookingId,
      this.rating,
      this.reviewText,
      this.status,
      this.photos,
      this.createdAt,
      this.updatedAt,
      this.user});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cafeId = json['cafe_id'];
    bookingId = json['booking_id'];
    rating = json['rating'];
    reviewText = json['review_text'];
    status = json['status'];
    photos = json['photos']?.cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? ReviewUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['cafe_id'] = cafeId;
    data['booking_id'] = bookingId;
    data['rating'] = rating;
    data['review_text'] = reviewText;
    data['status'] = status;
    data['photos'] = photos;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ReviewUser {
  int? id;
  String? name;
  String? profilePicture;
  bool? isEmailVerified;

  ReviewUser({this.id, this.name, this.profilePicture, this.isEmailVerified});

  ReviewUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    isEmailVerified = json['is_email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_picture'] = profilePicture;
    data['is_email_verified'] = isEmailVerified;
    return data;
  }
}

class Ads {
  String? id;
  String? cafeId;
  int? durationDays;
  String? startDate;
  String? endDate;
  int? tokensSpent;
  String? status;
  String? createdAt;
  String? updatedAt;

  Ads(
      {this.id,
      this.cafeId,
      this.durationDays,
      this.startDate,
      this.endDate,
      this.tokensSpent,
      this.status,
      this.createdAt,
      this.updatedAt});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cafeId = json['cafe_id'];
    durationDays = json['duration_days'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    tokensSpent = json['tokens_spent'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cafe_id'] = cafeId;
    data['duration_days'] = durationDays;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['tokens_spent'] = tokensSpent;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
