class offerResponse {
  String? _msg;
  List<Data>? _data;
  bool? _success;

  offerResponse({String? msg, List<Data>? data, bool? success}) {
    this._msg = msg;
    this._data = data;
    this._success = success;
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  offerResponse.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this._msg;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this._success;
    return data;
  }
}

class Data {
  int? _couponId;
  String? _desc;
  String? _code;
  int? _maxUse;
  int? _useCount;
  String? _type;
  int? _discount;
  String? _startDate;
  String? _endDate;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  Data(
      {int? couponId,
        String? desc,
        String? code,
        int? maxUse,
        int? useCount,
        String? type,
        int? discount,
        String? startDate,
        String? endDate,
        int? status,
        String? createdAt,
        String? updatedAt}) {
    this._couponId = couponId;
    this._desc = desc;
    this._code = code;
    this._maxUse = maxUse;
    this._useCount = useCount;
    this._type = type;
    this._discount = discount;
    this._startDate = startDate;
    this._endDate = endDate;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get couponId => _couponId;
  set couponId(int? couponId) => _couponId = couponId;
  String? get desc => _desc;
  set desc(String? desc) => _desc = desc;
  String? get code => _code;
  set code(String? code) => _code = code;
  int? get maxUse => _maxUse;
  set maxUse(int? maxUse) => _maxUse = maxUse;
  int? get useCount => _useCount;
  set useCount(int? useCount) => _useCount = useCount;
  String? get type => _type;
  set type(String? type) => _type = type;
  int? get discount => _discount;
  set discount(int? discount) => _discount = discount;
  String? get startDate => _startDate;
  set startDate(String? startDate) => _startDate = startDate;
  String? get endDate => _endDate;
  set endDate(String? endDate) => _endDate = endDate;
  int? get status => _status;
  set status(int? status) => _status = status;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    _couponId = json['coupon_id'];
    _desc = json['desc'];
    _code = json['code'];
    _maxUse = json['max_use'];
    _useCount = json['use_count'];
    _type = json['type'];
    _discount = json['discount'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this._couponId;
    data['desc'] = this._desc;
    data['code'] = this._code;
    data['max_use'] = this._maxUse;
    data['use_count'] = this._useCount;
    data['type'] = this._type;
    data['discount'] = this._discount;
    data['start_date'] = this._startDate;
    data['end_date'] = this._endDate;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}