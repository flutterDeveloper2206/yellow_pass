class BookingDetailResponse {
  bool? status;
  int? statusCode;
  String? message;
  BookingDetailData? data;

  BookingDetailResponse({this.status, this.statusCode, this.message, this.data});

  BookingDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? BookingDetailData.fromJson(json['data']) : null;
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

class BookingDetailData {
  DetailedBooking? booking;

  BookingDetailData({this.booking});

  BookingDetailData.fromJson(Map<String, dynamic> json) {
    booking = json['booking'] != null ? DetailedBooking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    return data;
  }
}

class DetailedBooking {
  String? id;
  String? bookingCode;
  String? cafeId;
  int? userId;
  DetailCafe? cafe;
  DetailTable? table;
  String? startTime;
  String? endTime;
  String? bookingDay;
  String? bookingDate;
  String? type;
  int? durationHours;
  String? price;
  String? status;
  String? paymentStatus;
  String? checkInStatus;
  String? checkedInAt;
  String? checkedOutAt;
  String? createdAt;
  dynamic review;
  String? qrCode;

  DetailedBooking(
      {this.id,
      this.bookingCode,
      this.cafeId,
      this.userId,
      this.cafe,
      this.table,
      this.startTime,
      this.endTime,
      this.bookingDay,
      this.bookingDate,
      this.type,
      this.durationHours,
      this.price,
      this.status,
      this.paymentStatus,
      this.checkInStatus,
      this.checkedInAt,
      this.checkedOutAt,
      this.createdAt,
      this.review,
      this.qrCode});

  DetailedBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingCode = json['booking_code'];
    cafeId = json['cafe_id'];
    userId = json['user_id'];
    cafe = json['cafe'] != null ? DetailCafe.fromJson(json['cafe']) : null;
    table = json['table'] != null ? DetailTable.fromJson(json['table']) : null;
    startTime = json['start_time'];
    endTime = json['end_time'];
    bookingDay = json['booking_day'];
    bookingDate = json['booking_date'];
    type = json['type'];
    durationHours = json['duration_hours'];
    price = json['price']?.toString();
    status = json['status'];
    paymentStatus = json['payment_status'];
    checkInStatus = json['check_in_status'];
    checkedInAt = json['checked_in_at'];
    checkedOutAt = json['checked_out_at'];
    createdAt = json['created_at'];
    review = json['review'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_code'] = bookingCode;
    data['cafe_id'] = cafeId;
    data['user_id'] = userId;
    if (cafe != null) {
      data['cafe'] = cafe!.toJson();
    }
    if (table != null) {
      data['table'] = table!.toJson();
    }
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['booking_day'] = bookingDay;
    data['booking_date'] = bookingDate;
    data['type'] = type;
    data['duration_hours'] = durationHours;
    data['price'] = price;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    data['check_in_status'] = checkInStatus;
    data['checked_in_at'] = checkedInAt;
    data['checked_out_at'] = checkedOutAt;
    data['created_at'] = createdAt;
    data['review'] = review;
    data['qr_code'] = qrCode;
    return data;
  }
}

class DetailCafe {
  String? name;
  String? address;
  String? image;
  DetailLocation? location;

  DetailCafe({this.name, this.address, this.image, this.location});

  DetailCafe.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    image = json['image'];
    location = json['location'] != null ? DetailLocation.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['image'] = image;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class DetailLocation {
  String? lat;
  String? lng;

  DetailLocation({this.lat, this.lng});

  DetailLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class DetailTable {
  String? id;
  String? tableNumber;

  DetailTable({this.id, this.tableNumber});

  DetailTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableNumber = json['table_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['table_number'] = tableNumber;
    return data;
  }
}
