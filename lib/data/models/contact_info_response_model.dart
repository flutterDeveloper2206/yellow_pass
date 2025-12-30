class ContactInfoResponse {
  bool? status;
  int? statusCode;
  String? message;
  ContactData? data;

  ContactInfoResponse({this.status, this.statusCode, this.message, this.data});

  ContactInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? ContactData.fromJson(json['data']) : null;
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

class ContactData {
  String? email;
  String? phone;
  String? address;
  SocialMedia? socialMedia;
  String? supportHours;

  ContactData(
      {this.email,
      this.phone,
      this.address,
      this.socialMedia,
      this.supportHours});

  ContactData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    socialMedia = json['social_media'] != null
        ? SocialMedia.fromJson(json['social_media'])
        : null;
    supportHours = json['support_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    if (socialMedia != null) {
      data['social_media'] = socialMedia!.toJson();
    }
    data['support_hours'] = supportHours;
    return data;
  }
}

class SocialMedia {
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;

  SocialMedia({this.facebook, this.twitter, this.instagram, this.linkedin});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['instagram'] = instagram;
    data['linkedin'] = linkedin;
    return data;
  }
}
