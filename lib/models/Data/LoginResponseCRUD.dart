class LoginResponseCRUD {
  bool? status;
  String? token;

  LoginResponseCRUD({this.status, this.token});

  LoginResponseCRUD.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    return data;
  }
}