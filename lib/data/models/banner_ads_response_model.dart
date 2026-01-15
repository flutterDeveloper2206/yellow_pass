import 'cafe_response_model.dart';

class BannerAdsResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<Cafe>? data;

  BannerAdsResponse({this.status, this.statusCode, this.message, this.data});

  BannerAdsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Cafe>[];
      json['data'].forEach((v) {
        data!.add(Cafe.fromJson(v));
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
