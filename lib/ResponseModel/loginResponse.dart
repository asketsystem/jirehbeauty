import 'package:http/http.dart';

class loginResponse {
  bool? _success;
  String? _msg;
  Data? _data;


  loginResponse({bool? success, String? msg, Data? data}) {
    this._success = success;
    this._msg = msg;
    // this._data = data;
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  loginResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _msg = json['msg'];



    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['msg'] = this._msg;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class
Data {
  String? _token;

  Data({String? token}) {
    this._token = token;
  }

  String? get token => _token;
  set token(String? token) => _token = token;

  Data.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    return data;
  }
}