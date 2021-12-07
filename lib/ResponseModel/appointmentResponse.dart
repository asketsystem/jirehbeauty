class appointmentResponse {
  String? msg;
  Data? data;
  bool? success;

  appointmentResponse({this.msg, this.data, this.success});

  appointmentResponse.fromJson(Map<String, dynamic> json) {
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
  List<Completed>? completed;
  List<Cancel>? cancel;
  List<UpcomingOrder>? upcomingOrder;

  Data({this.completed, this.cancel, this.upcomingOrder});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['completed'] != null) {
      completed = <Completed>[];
      json['completed'].forEach((v) {
        completed!.add(new Completed.fromJson(v));
      });
    }
    if (json['cancel'] != null) {
      cancel = <Cancel>[];
      json['cancel'].forEach((v) {
        cancel!.add(new Cancel.fromJson(v));
      });
    }
    if (json['upcoming_order'] != null) {
      upcomingOrder = <UpcomingOrder>[];
      json['upcoming_order'].forEach((v) {
        upcomingOrder!.add(new UpcomingOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    if (this.cancel != null) {
      data['cancel'] = this.cancel!.map((v) => v.toJson()).toList();
    }
    if (this.upcomingOrder != null) {
      data['upcoming_order'] =
          this.upcomingOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Completed {
  int? id;
  String? bookingId;
  int? salonId;
  int? userId;
  int? empId;
  String? serviceId;
  int? couponId;
  int? discount;
  int? payment;
  String? date;
  String? startTime;
  String? endTime;
  String? paymentType;
  String? paymentToken;
  int? paymentStatus;
  String? bookingStatus;
  int? commission;
  int? salonIncome;
  String? createdAt;
  String? updatedAt;
  List<Services>? services;
  UserDetails? userDetails;
  EmpDetails? empDetails;
  Salon? salon;
  Review? review;
  bool seeallvisible = true;
  bool serlistvisible = true;
  bool newlistvisible = false;

  Completed(
      {this.id,
      this.bookingId,
      this.salonId,
      this.userId,
      this.empId,
      this.serviceId,
      this.couponId,
      this.discount,
      this.payment,
      this.date,
      this.startTime,
      this.endTime,
      this.paymentType,
      this.paymentToken,
      this.paymentStatus,
      this.bookingStatus,
      this.commission,
      this.salonIncome,
      this.createdAt,
      this.updatedAt,
      this.services,
      this.userDetails,
      this.empDetails,
      this.salon,
      this.review});

  Completed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    empId = json['emp_id'];
    serviceId = json['service_id'];
    couponId = json['coupon_id'];
    discount = json['discount'];
    payment = json['payment'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    paymentType = json['payment_type'];
    paymentToken = json['payment_token'];
    paymentStatus = json['payment_status'];
    bookingStatus = json['booking_status'];
    commission = json['commission'];
    salonIncome = json['salon_income'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    empDetails = json['empDetails'] != null
        ? new EmpDetails.fromJson(json['empDetails'])
        : null;
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
    review =
        json['review'] != null ? new Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['salon_id'] = this.salonId;
    data['user_id'] = this.userId;
    data['emp_id'] = this.empId;
    data['service_id'] = this.serviceId;
    data['coupon_id'] = this.couponId;
    data['discount'] = this.discount;
    data['payment'] = this.payment;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['payment_type'] = this.paymentType;
    data['payment_token'] = this.paymentToken;
    data['payment_status'] = this.paymentStatus;
    data['booking_status'] = this.bookingStatus;
    data['commission'] = this.commission;
    data['salon_income'] = this.salonIncome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.empDetails != null) {
      data['empDetails'] = this.empDetails!.toJson();
    }
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.toJson();
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
  String? addedBy;
  String? emailVerifiedAt;
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

class EmpDetails {
  int? empId;
  int? salonId;
  String? name;
  String? image;
  String? email;
  int? phone;
  String? serviceId;
  String? sun;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  int? status;
  int? isdelete;
  String? createdAt;
  String? updatedAt;
  Sunday? sunday;
  Monday? monday;
  Monday? tuesday;
  Monday? wednesday;
  Monday? thursday;
  Monday? friday;
  Monday? saturday;
  String? imagePath;
  List<Services>? services;
  Salon? salon;

  EmpDetails(
      {this.empId,
      this.salonId,
      this.name,
      this.image,
      this.email,
      this.phone,
      this.serviceId,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.status,
      this.isdelete,
      this.createdAt,
      this.updatedAt,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.imagePath,
      this.services,
      this.salon});

  EmpDetails.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    salonId = json['salon_id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phone = json['phone'];
    serviceId = json['service_id'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    status = json['status'];
    isdelete = json['isdelete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sunday =
        json['sunday'] != null ? new Sunday.fromJson(json['sunday']) : null;
    monday =
        json['monday'] != null ? new Monday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Monday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Monday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Monday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Monday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Monday.fromJson(json['saturday']) : null;
    imagePath = json['imagePath'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['salon_id'] = this.salonId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['service_id'] = this.serviceId;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    data['sat'] = this.sat;
    data['status'] = this.status;
    data['isdelete'] = this.isdelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    data['imagePath'] = this.imagePath;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    return data;
  }
}

class Sunday {
  String? open;
  String? close;

  Sunday({this.open, this.close});

  Sunday.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}

class Monday {
  String? open;
  String? close;

  Monday({this.open, this.close});

  Monday.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}

class Salon {
  int? salonId;
  int? ownerId;
  String? name;
  String? image;
  String? logo;
  String? desc;
  String? gender;
  String? address;
  int? zipcode;
  String? city;
  String? state;
  String? country;
  String? website;
  int? phone;
  String? sun;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  int? status;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  Sunday? sunday;
  Monday? monday;
  Monday? tuesday;
  Monday? wednesday;
  Monday? thursday;
  Monday? friday;
  Monday? saturday;
  String? rate;
  String? imagePath;
  String? ownerName;
  OwnerDetails? ownerDetails;

  Salon(
      {this.salonId,
      this.ownerId,
      this.name,
      this.image,
      this.logo,
      this.desc,
      this.gender,
      this.address,
      this.zipcode,
      this.city,
      this.state,
      this.country,
      this.website,
      this.phone,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.status,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.rate,
      this.imagePath,
      this.ownerName,
      this.ownerDetails});

  Salon.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    ownerId = json['owner_id'];
    name = json['name'];
    image = json['image'];
    logo = json['logo'];
    desc = json['desc'];
    gender = json['gender'];
    address = json['address'];
    zipcode = json['zipcode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    website = json['website'];
    phone = json['phone'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sunday =
        json['sunday'] != null ? new Sunday.fromJson(json['sunday']) : null;
    monday =
        json['monday'] != null ? new Monday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Monday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Monday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Monday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Monday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Monday.fromJson(json['saturday']) : null;
    rate = json['rate'];
    imagePath = json['imagePath'];
    ownerName = json['ownerName'];
    ownerDetails = json['ownerDetails'] != null
        ? new OwnerDetails.fromJson(json['ownerDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['owner_id'] = this.ownerId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['logo'] = this.logo;
    data['desc'] = this.desc;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['zipcode'] = this.zipcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    data['sat'] = this.sat;
    data['status'] = this.status;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    data['rate'] = this.rate;
    data['imagePath'] = this.imagePath;
    data['ownerName'] = this.ownerName;
    if (this.ownerDetails != null) {
      data['ownerDetails'] = this.ownerDetails!.toJson();
    }
    return data;
  }
}

class OwnerDetails {
  int? id;
  String? name;
  String? image;
  String? email;
  Null otp;
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

  OwnerDetails(
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

  OwnerDetails.fromJson(Map<String, dynamic> json) {
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

class Cancel {
  int? id;
  String? bookingId;
  int? salonId;
  int? userId;
  int? empId;
  String? serviceId;
  Null couponId;
  int? discount;
  int? payment;
  String? date;
  String? startTime;
  String? endTime;
  String? paymentType;
  String? paymentToken;
  int? paymentStatus;
  String? bookingStatus;
  int? commission;
  int? salonIncome;
  String? createdAt;
  String? updatedAt;
  List<Services>? services;
  UserDetails? userDetails;
  EmpDetails? empDetails;
  Salon? salon;
  Null review;
  bool seeallvisible = true;
  bool serlistvisible = true;
  bool newlistvisible = false;

  Cancel(
      {this.id,
      this.bookingId,
      this.salonId,
      this.userId,
      this.empId,
      this.serviceId,
      this.couponId,
      this.discount,
      this.payment,
      this.date,
      this.startTime,
      this.endTime,
      this.paymentType,
      this.paymentToken,
      this.paymentStatus,
      this.bookingStatus,
      this.commission,
      this.salonIncome,
      this.createdAt,
      this.updatedAt,
      this.services,
      this.userDetails,
      this.empDetails,
      this.salon,
      this.review});

  Cancel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    empId = json['emp_id'];
    serviceId = json['service_id'];
    couponId = json['coupon_id'];
    discount = json['discount'];
    payment = json['payment'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    paymentType = json['payment_type'];
    paymentToken = json['payment_token'];
    paymentStatus = json['payment_status'];
    bookingStatus = json['booking_status'];
    commission = json['commission'];
    salonIncome = json['salon_income'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    empDetails = json['empDetails'] != null
        ? new EmpDetails.fromJson(json['empDetails'])
        : null;
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
    review = json['review'] != null
        ? new Review.fromJson(json['review']) as Null
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['salon_id'] = this.salonId;
    data['user_id'] = this.userId;
    data['emp_id'] = this.empId;
    data['service_id'] = this.serviceId;
    data['coupon_id'] = this.couponId;
    data['discount'] = this.discount;
    data['payment'] = this.payment;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['payment_type'] = this.paymentType;
    data['payment_token'] = this.paymentToken;
    data['payment_status'] = this.paymentStatus;
    data['booking_status'] = this.bookingStatus;
    data['commission'] = this.commission;
    data['salon_income'] = this.salonIncome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.empDetails != null) {
      data['empDetails'] = this.empDetails!.toJson();
    }
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    /* if (this.review != null) {
      data['review'] = this.review.toJson();
    }*/
    return data;
  }
}

class Review {
  int? reviewId;
  int? userId;
  int? bookingId;
  int? rate;
  String? message;
  String? createdAt;

  Review(
      {this.reviewId,
      this.userId,
      this.bookingId,
      this.rate,
      this.message,
      this.createdAt});

  Review.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    rate = json['rate'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['user_id'] = this.userId;
    data['booking_id'] = this.bookingId;
    data['rate'] = this.rate;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class UpcomingOrder {
  int? id;
  String? bookingId;
  int? salonId;
  int? userId;
  int? empId;
  String? serviceId;
  Null couponId;
  int? discount;
  dynamic? payment;
  String? date;
  String? startTime;
  String? endTime;
  String? paymentType;
  String? paymentToken;
  int? paymentStatus;
  String? bookingStatus;
  int? commission;
  int? salonIncome;
  String? createdAt;
  String? updatedAt;
  List<Services>? services;
  UserDetails? userDetails;
  EmpDetails? empDetails;
  Salon? salon;
  bool seeallvisible = true;
  bool serlistvisible = true;
  bool newlistvisible = false;

  UpcomingOrder(
      {this.id,
      this.bookingId,
      this.salonId,
      this.userId,
      this.empId,
      this.serviceId,
      this.couponId,
      this.discount,
      this.payment,
      this.date,
      this.startTime,
      this.endTime,
      this.paymentType,
      this.paymentToken,
      this.paymentStatus,
      this.bookingStatus,
      this.commission,
      this.salonIncome,
      this.createdAt,
      this.updatedAt,
      this.services,
      this.userDetails,
      this.empDetails,
      this.salon});

  UpcomingOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    empId = json['emp_id'];
    serviceId = json['service_id'];
    couponId = json['coupon_id'];
    discount = json['discount'];
    payment = json['payment'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    paymentType = json['payment_type'];
    paymentToken = json['payment_token'];
    paymentStatus = json['payment_status'];
    bookingStatus = json['booking_status'];
    commission = json['commission'];
    salonIncome = json['salon_income'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    empDetails = json['empDetails'] != null
        ? new EmpDetails.fromJson(json['empDetails'])
        : null;
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['salon_id'] = this.salonId;
    data['user_id'] = this.userId;
    data['emp_id'] = this.empId;
    data['service_id'] = this.serviceId;
    data['coupon_id'] = this.couponId;
    data['discount'] = this.discount;
    data['payment'] = this.payment;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['payment_type'] = this.paymentType;
    data['payment_token'] = this.paymentToken;
    data['payment_status'] = this.paymentStatus;
    data['booking_status'] = this.bookingStatus;
    data['commission'] = this.commission;
    data['salon_income'] = this.salonIncome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.empDetails != null) {
      data['empDetails'] = this.empDetails!.toJson();
    }
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    return data;
  }
}
