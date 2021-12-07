class removeAddressResponse {
  String? msg;
  bool? success;

  removeAddressResponse({this.msg, this.success});

  removeAddressResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    return data;
  }
}