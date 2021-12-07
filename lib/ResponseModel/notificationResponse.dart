class notificationResponse {
  String? msg;
  List<NotiData>? data;
  bool? success;

  notificationResponse({this.msg, this.data, this.success});

  notificationResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <NotiData>[];
      json['data'].forEach((v) {
        data!.add(new NotiData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class NotiData {
  int? id;

  int? bookingId;
  String? title;
  String? msg;

  NotiData({
    this.id,
    this.bookingId,
    this.title,
    this.msg,
  });

  NotiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    bookingId = json['booking_id'];
    title = json['title'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['booking_id'] = this.bookingId;
    data['title'] = this.title;
    data['msg'] = this.msg;
    return data;
  }
}
