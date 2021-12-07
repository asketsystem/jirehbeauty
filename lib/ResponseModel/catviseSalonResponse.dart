class catviseSalonResponse {
  String? msg;
  List<CatSalonData>? data;
  bool? success;

  catviseSalonResponse({this.msg, this.data, this.success});

  catviseSalonResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CatSalonData>[];
      json['data'].forEach((v) {
        data!.add(new CatSalonData.fromJson(v));
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

class CatSalonData {
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
  Sunday? monday;
  Sunday? tuesday;
  Sunday? wednesday;
  Sunday? thursday;
  Sunday? friday;
  Sunday? saturday;
  String? rate;
  String? imagePath;
  String? ownerName;
  OwnerDetails? ownerDetails;

  CatSalonData(
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

  CatSalonData.fromJson(Map<String, dynamic> json) {
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
        json['monday'] != null ? new Sunday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Sunday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Sunday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Sunday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Sunday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Sunday.fromJson(json['saturday']) : null;
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
