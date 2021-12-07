class categorydataResponse {
  String? _msg;
  List<CategoryData>? _data;
  bool? _success;

  categorydataResponse({String? msg, List<CategoryData>? data, bool? success}) {
    this._msg = msg;
    this._data = data;
    this._success = success;
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<CategoryData>? get data => _data;
  set data(List<CategoryData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  categorydataResponse.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = <CategoryData>[];
      json['data'].forEach((v) {
        _data!.add(new CategoryData.fromJson(v));
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

class CategoryData {
  int? _catId;
  String? _name;
  String? _image;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;

  CategoryData(
      {int? catId,
      String? name,
      String? image,
      int? status,
      String? createdAt,
      String? updatedAt,
      String? imagePath}) {
    this._catId = catId;
    this._name = name;
    this._image = image;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._imagePath = imagePath;
  }

  int? get catId => _catId;
  set catId(int? catId) => _catId = catId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;
  int? get status => _status;
  set status(int? status) => _status = status;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;

  CategoryData.fromJson(Map<String, dynamic> json) {
    _catId = json['cat_id'];
    _name = json['name'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this._catId;
    data['name'] = this._name;
    data['image'] = this._image;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['imagePath'] = this._imagePath;
    return data;
  }
}
