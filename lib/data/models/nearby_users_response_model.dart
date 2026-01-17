class NearbyUsersResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<NearbyUser>? data;

  NearbyUsersResponse({this.status, this.statusCode, this.message, this.data});

  NearbyUsersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NearbyUser>[];
      json['data'].forEach((v) {
        data!.add(NearbyUser.fromJson(v));
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

class NearbyUser {
  int? id;
  String? name;
  String? email;
  String? profilePicture;
  String? description;
  String? latitude;
  String? longitude;
  double? distance;
  bool? isEmailVerified;

  NearbyUser({
    this.id,
    this.name,
    this.email,
    this.profilePicture,
    this.description,
    this.latitude,
    this.longitude,
    this.distance,
    this.isEmailVerified,
  });

  NearbyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profilePicture = json['profile_picture'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance']?.toDouble();
    isEmailVerified = json['is_email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['profile_picture'] = profilePicture;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance'] = distance;
    data['is_email_verified'] = isEmailVerified;
    return data;
  }
}
