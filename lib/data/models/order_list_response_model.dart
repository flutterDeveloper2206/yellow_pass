class OrderListResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<OrderData>? data;

  OrderListResponseModel(
      {this.status, this.statusCode, this.message, this.data});

  OrderListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
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

class OrderData {
  String? id;
  String? bookingId;
  int? userId;
  String? cafeId;
  List<OrderItem>? items;
  String? totalAmount;
  String? status;
  String? createdAt;
  String? updatedAt;

  OrderData({
    this.id,
    this.bookingId,
    this.userId,
    this.cafeId,
    this.items,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id']?.toString();
    userId = json['user_id'];
    cafeId = json['cafe_id'];
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(OrderItem.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['user_id'] = userId;
    data['cafe_id'] = cafeId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class OrderItem {
  String? name;
  String? price;
  int? quantity;
  String? menuItemId;
  String? imageUrl;

  OrderItem(
      {this.name, this.price, this.quantity, this.menuItemId, this.imageUrl});

  OrderItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    menuItemId = json['menu_item_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['menu_item_id'] = menuItemId;
    data['image_url'] = imageUrl;
    return data;
  }
}
