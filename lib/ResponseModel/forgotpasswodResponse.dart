class forgotpasswodResponse {
  String? msg;
  Data? data;
  bool? success;

  forgotpasswodResponse({this.msg, this.data, this.success});

  forgotpasswodResponse.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? image;
  String? email;
  int? otp;
  Null addedBy;
  Null emailVerifiedAt;
  String? code;
  int? id;
  String? phone;
  int? status;
  int? role;
  int? verify;
  Null deviceToken;
  int? notification;
  int? mail;
  String? createdAt;
  String? updatedAt;
  String? imagePath;
  String? salonName;

  Data(
      {this.id,
        this.name,
        this.image,
        this.email,
        this.otp,
        this.addedBy,
        this.emailVerifiedAt,
        this.code,
        this.phone,
        this.status,
        this.role,
        this.verify,
        this.deviceToken,
        this.notification,
        this.mail,
        this.createdAt,
        this.updatedAt,
        this.imagePath,
        this.salonName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    otp = json['otp'];
    addedBy = json['added_by'];
    emailVerifiedAt = json['email_verified_at'];
    code = json['code'];
    phone = json['phone'];
    status = json['status'];
    role = json['role'];
    verify = json['verify'];
    deviceToken = json['device_token'];
    notification = json['notification'];
    mail = json['mail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['imagePath'];
    salonName = json['salonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['added_by'] = this.addedBy;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['code'] = this.code;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['role'] = this.role;
    data['verify'] = this.verify;
    data['device_token'] = this.deviceToken;
    data['notification'] = this.notification;
    data['mail'] = this.mail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['imagePath'] = this.imagePath;
    data['salonName'] = this.salonName;
    return data;
  }
}