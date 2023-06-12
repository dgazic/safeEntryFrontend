class LoginResponseModel {
  String? token;
  final String? error;
  bool? success;

  LoginResponseModel({this.token, this.error, this.success});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        token: json["token"] != null ? json["token"] : "",
        error: json["error"],
        success: json["success"]);
  }
}

class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username!.trim(),
      'password': password!.trim(),
    };

    return map;
  }
}
