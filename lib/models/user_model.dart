class UserResponseModel {
  String? companyName;
  String? email;
  String? address;
  int? userRoleId;
  String? phoneNumber;
  String? firstName;
  String? lastName;

  UserResponseModel(
      {this.companyName,
      this.email,
      this.address,
      this.userRoleId,
      this.phoneNumber,
      this.firstName,
      this.lastName});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      companyName: json["companyName"],
      email: json["email"],
      address: json["address"],
      userRoleId: json["userRoleId"],
      phoneNumber: json["phoneNumber"],
      firstName: json["firstName"],
      lastName: json["lastName"],
    );
  }
}

class UserRequestModel {
  int? id;
  String? email;
  String? username;
  String? lastName;
  String? firstName;
  int? userRoleId;
  String? phoneNumber;
  int? activated;

  UserRequestModel(
      {this.id,
      this.email,
      this.username,
      this.lastName,
      this.firstName,
      this.userRoleId,
      this.phoneNumber,
      this.activated});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id!,
      'lastName': lastName,
      'firstName': firstName,
      'email': email,
      'username': username,
      'userRoleId': userRoleId,
      'phoneNumber': phoneNumber,
      'activated': activated
    };

    return map;
  }
}
