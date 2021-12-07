class offerbannerResppose {
  String? _msg;
  List<Offerbanner>? _offerbanner;
  bool? _success;

  offerbannerResppose({String? msg, List<Offerbanner>? data, bool? success}) {
    this._msg = msg;
    this._offerbanner = data;
    this._success = success;
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<Offerbanner>? get data => _offerbanner;
  set data(List<Offerbanner>? data) => _offerbanner = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  offerbannerResppose.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _offerbanner = <Offerbanner>[];
      json['data'].forEach((v) {
        _offerbanner!.add(new Offerbanner.fromJson(v));
      });
    }
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this._msg;
    if (this._offerbanner != null) {
      data['data'] = this._offerbanner!.map((v) => v.toJson()).toList();
    }
    data['success'] = this._success;
    return data;
  }
}

class Offerbanner {
  int? _id;
  String? _image;
  String? _title;
  int? _discount;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;

  Offerbanner(
      {int? id,
      String? image,
      String? title,
      int? discount,
      int? status,
      String? createdAt,
      String? updatedAt,
      String? imagePath}) {
    this._id = id;
    this._image = image;
    this._title = title;
    this._discount = discount;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._imagePath = imagePath;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get title => _title;
  set title(String? title) => _title = title;
  int? get discount => _discount;
  set discount(int? discount) => _discount = discount;
  int? get status => _status;
  set status(int? status) => _status = status;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;

  Offerbanner.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _image = json['image'];
    _title = json['title'];
    _discount = json['discount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['image'] = this._image;
    data['title'] = this._title;
    data['discount'] = this._discount;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['imagePath'] = this._imagePath;
    return data;
  }
}
