class NotificationResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<NotificationData>? data;

  NotificationResponse({this.status, this.statusCode, this.message, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
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

class NotificationData {
  int? id;
  String? title;
  String? message;
  String? type;
  bool? read;
  String? createdAt;

  NotificationData(
      {this.id,
      this.title,
      this.message,
      this.type,
      this.read,
      this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    read = json['read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['type'] = type;
    data['read'] = read;
    data['created_at'] = createdAt;
    return data;
  }
}
