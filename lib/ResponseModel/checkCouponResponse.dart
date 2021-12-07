class checkCouponResponse {
  String? msg;
  Data? data;
  bool? success;

  checkCouponResponse({this.msg, this.data, this.success});

  checkCouponResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? couponId;
  String? desc;
  String? code;
  int? maxUse;
  int? useCount;
  String? type;
  int? discount;
  String? startDate;
  String? endDate;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.couponId,
        this.desc,
        this.code,
        this.maxUse,
        this.useCount,
        this.type,
        this.discount,
        this.startDate,
        this.endDate,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    desc = json['desc'];
    code = json['code'];
    maxUse = json['max_use'];
    useCount = json['use_count'];
    type = json['type'];
    discount = json['discount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['desc'] = this.desc;
    data['code'] = this.code;
    data['max_use'] = this.maxUse;
    data['use_count'] = this.useCount;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}