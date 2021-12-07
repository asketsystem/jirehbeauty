class salonDetailResponse {
  String? msg;
  Data? data;
  bool? success;

  salonDetailResponse({this.msg, this.data, this.success});

  salonDetailResponse.fromJson(Map<String, dynamic> json) {
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
  Salon? salon;
  List<Gallery>? gallery;
  List<Category>? category;
  List<Review>? review;

  Data({this.salon, this.gallery, this.category, this.review});

  Data.fromJson(Map<String, dynamic> json) {
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
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
  Sunday? monday;
  Sunday? tuesday;
  Sunday? wednesday;
  Sunday? thursday;
  Sunday? friday;
  Sunday? saturday;
  var rate;
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

class Category {
  int? catId;
  String? name;
  String? image;
  List<Service>? service;
  String? imagePath;

  Category({this.catId, this.name, this.image, this.service, this.imagePath});

  Category.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    name = json['name'];
    image = json['image'];
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(new Service.fromJson(v));
      });
    }
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class Service {
  int? serviceId;
  String? image;
  String? name;
  int? price;
  String? imagePath;
  bool isSelected = false;

  Service({this.serviceId, this.image, this.name, this.price, this.imagePath});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    price = json['price'];

    image = json['image'];
    name = json['name'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;

    data['imagePath'] = this.imagePath;
    return data;
  }
}

class Gallery {
  int? galleryId;
  String? image;
  String? imagePath;

  Gallery({this.galleryId, this.image, this.imagePath});

  Gallery.fromJson(Map<String, dynamic> json) {
    galleryId = json['gallery_id'];
    image = json['image'];
    imagePath = json['imagePath'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gallery_id'] = this.galleryId;
    data['image'] = this.image;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class Review {
  int? reviewId;
  int? userId;
  int? salonId;
  int? bookingId;
  int? rate;
  String? message;
  int? report;
  String? createdAt;
  String? updatedAt;
  User? user;

  Review(
      {this.reviewId,
      this.userId,
      this.salonId,
      this.bookingId,
      this.rate,
      this.message,
      this.report,
      this.createdAt,
      this.updatedAt,
      this.user});

  Review.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    userId = json['user_id'];
    salonId = json['salon_id'];
    bookingId = json['booking_id'];
    rate = json['rate'];
    message = json['message'];
    report = json['report'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['user_id'] = this.userId;
    data['salon_id'] = this.salonId;
    data['booking_id'] = this.bookingId;
    data['rate'] = this.rate;
    data['message'] = this.message;
    data['report'] = this.report;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
