class MeetingListResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<MeetingRequest>? data;

  MeetingListResponseModel(
      {this.status, this.statusCode, this.message, this.data});

  MeetingListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MeetingRequest>[];
      json['data'].forEach((v) {
        data!.add(MeetingRequest.fromJson(v));
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

class MeetingRequest {
  int? id;
  int? senderId;
  int? receiverId;
  int? cafeId;
  String? message;
  String? status;
  String? responseMessage;
  String? respondedAt;
  String? createdAt;
  String? updatedAt;
  MeetingUser? sender;
  MeetingUser? receiver;

  MeetingRequest({
    this.id,
    this.senderId,
    this.receiverId,
    this.cafeId,
    this.message,
    this.status,
    this.responseMessage,
    this.respondedAt,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.receiver,
  });

  MeetingRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    cafeId = json['cafe_id'];
    message = json['message'];
    status = json['status'];
    responseMessage = json['response_message'];
    respondedAt = json['responded_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender =
        json['sender'] != null ? MeetingUser.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? MeetingUser.fromJson(json['receiver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['cafe_id'] = cafeId;
    data['message'] = message;
    data['status'] = status;
    data['response_message'] = responseMessage;
    data['responded_at'] = respondedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    return data;
  }
}

class MeetingUser {
  int? id;
  String? name;
  String? profilePicture;
  bool? isEmailVerified;

  MeetingUser({this.id, this.name, this.profilePicture, this.isEmailVerified});

  MeetingUser.fromJson(Map<String, dynamic> json) {
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
