class RegisterResponseModel {
  final String? error;
  bool? success;

  RegisterResponseModel({this.error, this.success});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
        error: json["error"], success: json["success"]);
  }
}

class RegisterRequestModel {
  String? companyName;
  String? email;
  String? phoneNumber;
  String? lastName;
  String? firstName;
  String? address;
  int userRole;

  RegisterRequestModel(
      {this.lastName,
      this.firstName,
      this.email,
      required this.userRole,
      this.phoneNumber,
      this.companyName,
      this.address});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'LastName': lastName!.trim(),
      'FirstName': firstName!.trim(),
      'Email': email!.trim(),
      'UserRoleId': userRole,
      'PhoneNumber': phoneNumber,
      'CompanyName': companyName,
      'Address': address
    };

    return map;
  }
}
