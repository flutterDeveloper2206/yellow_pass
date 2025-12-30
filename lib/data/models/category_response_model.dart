class CategoryResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<String>? data;

  CategoryResponse({this.status, this.statusCode, this.message, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = json['data'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
