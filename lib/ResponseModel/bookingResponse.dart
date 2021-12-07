class bookingResponse {
  String? msg;
  BookingData? data;
  bool? success;

  bookingResponse({this.msg, this.data, this.success});

  bookingResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new BookingData.fromJson(json['data']) : null;
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

class BookingData {
  String? endTime;
  String? salonId;
  String? empId;
  String? serviceId;
  String? payment;
  String? startTime;
  String? date;
  String? paymentType;
  String? paymentToken;
  int? userId;
  String? bookingId;
  int? discount;
  String? bookingStatus;
  int? commission;
  int? salonIncome;
  String? updatedAt;
  String? createdAt;
  int? id;
  List<Services>? services;
  UserDetails? userDetails;

  BookingData(
      {
        this.endTime,
        this.salonId,
        this.empId,
        this.serviceId,
        this.payment,
        this.startTime,
        this.date,
        this.paymentType,
        this.paymentToken,
        this.userId,
        this.bookingId,
        this.discount,
        this.bookingStatus,
        this.commission,
        this.salonIncome,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.services,
        this.userDetails});

  BookingData.fromJson(Map<String, dynamic> json) {
    endTime = json['end_time'];
    salonId = json['salon_id'];
    empId = json['emp_id'];
    serviceId = json['service_id'];
    payment = json['payment'];
    startTime = json['start_time'];
    date = json['date'];
    paymentType = json['payment_type'];
    paymentToken = json['payment_token'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    discount = json['discount'];
    bookingStatus = json['booking_status'];
    commission = json['commission'];
    salonIncome = json['salon_income'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_time'] = this.endTime;
    data['salon_id'] = this.salonId;
    data['emp_id'] = this.empId;
    data['service_id'] = this.serviceId;
    data['payment'] = this.payment;
    data['start_time'] = this.startTime;
    data['date'] = this.date;
    data['payment_type'] = this.paymentType;
    data['payment_token'] = this.paymentToken;
    data['user_id'] = this.userId;
    data['booking_id'] = this.bookingId;
    data['discount'] = this.discount;
    data['booking_status'] = this.bookingStatus;
    data['commission'] = this.commission;
    data['salon_income'] = this.salonIncome;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class Services {
  int? serviceId;
  int? catId;
  int? salonId;
  String? image;
  String? name;
  int? time;
  String? gender;
  int? price;
  int? status;
  int? isdelete;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  Services(
      {this.serviceId,
        this.catId,
        this.salonId,
        this.image,
        this.name,
        this.time,
        this.gender,
        this.price,
        this.status,
        this.isdelete,
        this.createdAt,
        this.updatedAt,
        this.imagePath});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    catId = json['cat_id'];
    salonId = json['salon_id'];
    image = json['image'];
    name = json['name'];
    time = json['time'];
    gender = json['gender'];
    price = json['price'];
    status = json['status'];
    isdelete = json['isdelete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['cat_id'] = this.catId;
    data['salon_id'] = this.salonId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['time'] = this.time;
    data['gender'] = this.gender;
    data['price'] = this.price;
    data['status'] = this.status;
    data['isdelete'] = this.isdelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class UserDetails {
  int? id;
  String? name;
  String? image;
  String? email;
  int? otp;
  Null addedBy;
  Null emailVerifiedAt;
  String? code;
  String? phone;
  int? status;
  int? role;
  int? verify;
  String? deviceToken;
  int? notification;
  int? mail;
  String? createdAt;
  String? updatedAt;
  String? imagePath;
  String? salonName;

  UserDetails(
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

  UserDetails.fromJson(Map<String, dynamic> json) {
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