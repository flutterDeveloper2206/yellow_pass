class TableTypeResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<TableType>? data;

  TableTypeResponse({this.status, this.statusCode, this.message, this.data});

  TableTypeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TableType>[];
      json['data'].forEach((v) {
        data!.add(TableType.fromJson(v));
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

class TableType {
  String? id;
  String? name;
  int? capacity;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;
  int? availableQuantity;

  TableType(
      {this.id,
      this.name,
      this.capacity,
      this.isDefault,
      this.createdAt,
      this.updatedAt,
      this.availableQuantity});

  TableType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capacity = json['capacity'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    availableQuantity = json['available_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['capacity'] = capacity;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['available_quantity'] = availableQuantity;
    return data;
  }
}
