class AvailabilityResponse {
  bool? status;
  int? statusCode;
  String? message;
  AvailabilityData? data;

  AvailabilityResponse({this.status, this.statusCode, this.message, this.data});

  AvailabilityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? AvailabilityData.fromJson(json['data']) : null;
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

class AvailabilityData {
  List<String>? slots;

  AvailabilityData({this.slots});

  AvailabilityData.fromJson(Map<String, dynamic> json) {
    slots = json['slots']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slots'] = slots;
    return data;
  }
}
