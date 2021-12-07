class registerResponse {
  bool? _success;
  Data? _data;
  String? _message;

  registerResponse({bool? success, Data? data, String? message}) {
    this._success = success;
    this._data = data;
    this._message = message;
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  Data? get data => _data;
  set data(Data? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;

  registerResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['message'] = this._message;
    return data;
  }
}

class Data {
  String? _name;
  String? _email;
  String? _code;
  String? _phone;
  int? _verify;
  String? _updatedAt;
  String? _createdAt;
  int? _id;
  int? _otp;
  String? _imagePath;
  String? _salonName;

  Data(
      {String? name,
        String? email,
        String? code,
        String? phone,
        int? verify,
        String? updatedAt,
        String? createdAt,
        int? id,
        int? otp,
        String? imagePath,
        String? salonName}) {
    this._name = name;
    this._email = email;
    this._code = code;
    this._phone = phone;
    this._verify = verify;
    this._updatedAt = updatedAt;
    this._createdAt = createdAt;
    this._id = id;
    this._otp = otp;
    this._imagePath = imagePath;
    this._salonName = salonName;
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get code => _code;
  set code(String? code) => _code = code;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  int? get verify => _verify;
  set verify(int? verify) => _verify = verify;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  int? get id => _id;
  set id(int? id) => _id = id;
  int? get otp => _otp;
  set otp(int? otp) => _otp = otp;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;
  String? get salonName => _salonName;
  set salonName(String? salonName) => _salonName = salonName;

  Data.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
    _code = json['code'];
    _phone = json['phone'];
    _verify = json['verify'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
    _otp = json['otp'];
    _imagePath = json['imagePath'];
    _salonName = json['salonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['email'] = this._email;
    data['code'] = this._code;
    data['phone'] = this._phone;
    data['verify'] = this._verify;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['id'] = this._id;
    data['otp'] = this._otp;
    data['imagePath'] = this._imagePath;
    data['salonName'] = this._salonName;
    return data;
  }
}