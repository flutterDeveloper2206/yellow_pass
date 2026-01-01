class CheckInResponse {
  bool? status;
  int? statusCode;
  String? message;
  // dynamic? data;

  CheckInResponse({this.status, this.statusCode, this.message, });

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    // data = json['data'] != null ? CheckInData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    return data;
  }
}
