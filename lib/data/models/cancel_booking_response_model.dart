class CancelBookingResponse {
  bool? status;
  int? statusCode;
  String? message;
  CancelBookingData? data;

  CancelBookingResponse({this.status, this.statusCode, this.message, this.data});

  CancelBookingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? CancelBookingData.fromJson(json['data']) : null;
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

class CancelBookingData {
  CancelledBooking? booking;

  CancelBookingData({this.booking});

  CancelBookingData.fromJson(Map<String, dynamic> json) {
    booking = json['booking'] != null ? CancelledBooking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    return data;
  }
}

class CancelledBooking {
  String? id;
  String? bookingCode;
  String? qrCode;
  String? qrExpiresAt;
  String? checkInStatus;
  String? checkedInAt;
  String? checkedOutAt;
  int? userId;
  String? cafeId;
  String? tableId;
  String? startTime;
  String? endTime;
  int? durationHours;
  String? status;
  String? price;
  String? paymentStatus;
  String? paymentMethod;
  int? tokenSpent;
  int? tokenPaidToCafe;
  String? specialRequests;
  String? createdAt;
  String? updatedAt;

  CancelledBooking(
      {this.id,
      this.bookingCode,
      this.qrCode,
      this.qrExpiresAt,
      this.checkInStatus,
      this.checkedInAt,
      this.checkedOutAt,
      this.userId,
      this.cafeId,
      this.tableId,
      this.startTime,
      this.endTime,
      this.durationHours,
      this.status,
      this.price,
      this.paymentStatus,
      this.paymentMethod,
      this.tokenSpent,
      this.tokenPaidToCafe,
      this.specialRequests,
      this.createdAt,
      this.updatedAt});

  CancelledBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingCode = json['booking_code'];
    qrCode = json['qr_code'];
    qrExpiresAt = json['qr_expires_at'];
    checkInStatus = json['check_in_status'];
    checkedInAt = json['checked_in_at'];
    checkedOutAt = json['checked_out_at'];
    userId = json['user_id'];
    cafeId = json['cafe_id'];
    tableId = json['table_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    durationHours = json['duration_hours'];
    status = json['status'];
    price = json['price']?.toString();
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    tokenSpent = json['token_spent'];
    tokenPaidToCafe = json['token_paid_to_cafe'];
    specialRequests = json['special_requests'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_code'] = bookingCode;
    data['qr_code'] = qrCode;
    data['qr_expires_at'] = qrExpiresAt;
    data['check_in_status'] = checkInStatus;
    data['checked_in_at'] = checkedInAt;
    data['checked_out_at'] = checkedOutAt;
    data['user_id'] = userId;
    data['cafe_id'] = cafeId;
    data['table_id'] = tableId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration_hours'] = durationHours;
    data['status'] = status;
    data['price'] = price;
    data['payment_status'] = paymentStatus;
    data['payment_method'] = paymentMethod;
    data['token_spent'] = tokenSpent;
    data['token_paid_to_cafe'] = tokenPaidToCafe;
    data['special_requests'] = specialRequests;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
