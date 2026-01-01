class CheckOutResponse {
  bool? status;
  int? statusCode;
  String? message;

  CheckOutResponse({this.status, this.statusCode, this.message, });

  CheckOutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;

    return data;
  }
}

