class UserBookingResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<UserBookingData>? data;

  UserBookingResponse({this.status, this.statusCode, this.message, this.data});

  UserBookingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserBookingData>[];
      json['data'].forEach((v) {
        data!.add(UserBookingData.fromJson(v));
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

class UserBookingData {
  String? id;
  String? bookingCode;
  String? cafeId;
  BookingCafe? cafe;
  BookingTable? table;
  String? startTime;
  String? endTime;
  String? bookingDay;
  String? bookingDate;
  String? type;
  int? durationHours;
  String? price;
  String? status;
  String? checkInStatus;
  String? checkedInAt;
  BookingReview? review;

  UserBookingData(
      {this.id,
      this.bookingCode,
      this.cafeId,
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
      this.checkInStatus,
      this.checkedInAt,
      this.review});

  UserBookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingCode = json['booking_code'];
    cafeId = json['cafe_id'];
    cafe = json['cafe'] != null ? BookingCafe.fromJson(json['cafe']) : null;
    table = json['table'] != null ? BookingTable.fromJson(json['table']) : null;
    startTime = json['start_time'];
    endTime = json['end_time'];
    bookingDay = json['booking_day'];
    bookingDate = json['booking_date'];
    type = json['type'];
    durationHours = json['duration_hours'];
    price = json['price']?.toString();
    status = json['status'];
    checkInStatus = json['check_in_status'];
    checkedInAt = json['checked_in_at'];
    review = json['review'] != null ? BookingReview.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_code'] = bookingCode;
    data['cafe_id'] = cafeId;
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
    data['check_in_status'] = checkInStatus;
    data['checked_in_at'] = checkedInAt;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    return data;
  }
}

class BookingCafe {
  String? name;
  String? address;
  String? image;

  BookingCafe({this.name, this.address, this.image});

  BookingCafe.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['image'] = image;
    return data;
  }
}

class BookingTable {
  String? tableNumber;

  BookingTable({this.tableNumber});

  BookingTable.fromJson(Map<String, dynamic> json) {
    tableNumber = json['table_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['table_number'] = tableNumber;
    return data;
  }
}

class BookingReview {
  String? id;
  int? rating;
  String? reviewText;
  List<String>? photos;
  String? createdAt;

  BookingReview(
      {this.id, this.rating, this.reviewText, this.photos, this.createdAt});

  BookingReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    reviewText = json['review_text'];
    photos = json['photos']?.cast<String>();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['review_text'] = reviewText;
    data['photos'] = photos;
    data['created_at'] = createdAt;
    return data;
  }
}
