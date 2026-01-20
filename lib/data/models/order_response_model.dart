class OrderResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  OrderData? data;

  OrderResponseModel({this.status, this.statusCode, this.message, this.data});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? OrderData.fromJson(json['data']) : null;
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

class OrderData {
  int? userId;
  String? cafeId;
  String? bookingId;
  List<OrderItem>? items;
  String? totalAmount;
  String? status;
  String? id;
  String? updatedAt;
  String? createdAt;

  OrderData(
      {this.userId,
      this.cafeId,
      this.bookingId,
      this.items,
      this.totalAmount,
      this.status,
      this.id,
      this.updatedAt,
      this.createdAt});

  OrderData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    cafeId = json['cafe_id'];
    bookingId = json['booking_id']?.toString();
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(OrderItem.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    status = json['status'];
    id = json['id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['cafe_id'] = cafeId;
    data['booking_id'] = bookingId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}

class OrderItem {
  String? menuItemId;
  String? name;
  int? quantity;
  String? price;

  OrderItem({this.menuItemId, this.name, this.quantity, this.price});

  OrderItem.fromJson(Map<String, dynamic> json) {
    menuItemId = json['menu_item_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_item_id'] = menuItemId;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
