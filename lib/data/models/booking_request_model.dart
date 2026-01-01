class BookingRequest {
  String? cafeId;
  String? tableTypeId;
  String? userId;
  String? startTime;
  String? endTime;
  int? tokenCost;
  String? specialRequests;

  BookingRequest(
      {this.cafeId,
      this.tableTypeId,
      this.userId,
      this.startTime,
      this.endTime,
      this.tokenCost,
      this.specialRequests});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cafe_id'] = cafeId;
    data['table_type_id'] = tableTypeId;
    data['user_id'] = userId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['token_cost'] = tokenCost;
    data['special_requests'] = specialRequests;
    return data;
  }
}
