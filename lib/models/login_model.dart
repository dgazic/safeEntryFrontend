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
  String? email;
  String? password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email!.trim(),
      'password': password!.trim(),
    };

    return map;
  }
}
