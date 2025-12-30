import 'cafe_response_model.dart';

class CafeDetailsResponse {
  bool? status;
  int? statusCode;
  String? message;
  Cafe? data;

  CafeDetailsResponse({this.status, this.statusCode, this.message, this.data});

  CafeDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Cafe.fromJson(json['data']) : null;
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
