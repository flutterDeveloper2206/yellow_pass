class MeetingRequestResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  MeetingRequestData? data;

  MeetingRequestResponseModel(
      {this.status, this.statusCode, this.message, this.data});

  MeetingRequestResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data =
        json['data'] != null ? MeetingRequestData.fromJson(json['data']) : null;
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

class MeetingRequestData {
  int? senderId;
  int? receiverId;
  String? message;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  MeetingRequestData({
    this.senderId,
    this.receiverId,
    this.message,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  MeetingRequestData.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
