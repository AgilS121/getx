class LoginResponse {
  bool? error;
  String? message;
  LoginResult? loginResult;

  LoginResponse({this.error, this.message, this.loginResult});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    loginResult = json['loginResult'] != null
        ? new LoginResult.fromJson(json['loginResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.loginResult != null) {
      data['loginResult'] = this.loginResult!.toJson();
    }
    return data;
  }
}

class LoginResult {
  String? userId;
  String? name;
  String? token;

  LoginResult({this.userId, this.name, this.token});

  LoginResult.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['token'] = this.token;
    return data;
  }
}


// class LoginResponse {
//   String? token;
  

//   LoginResponse({this.token});

//   LoginResponse.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     return data;
//   }
// }