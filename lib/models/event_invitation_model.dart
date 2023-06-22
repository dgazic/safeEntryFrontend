class EventInvitationRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  int? eventId;
  bool? active;

  EventInvitationRequestModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.eventId,
      this.active});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'firstName': firstName!,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'eventId': eventId,
      'active': active,
    };

    return map;
  }
}

class EventInvitationResponseModel {
  String? firstName;
  String? lastName;
  final String? error;
  bool? success;

  EventInvitationResponseModel(
      {this.firstName, this.lastName, this.error, this.success});

  factory EventInvitationResponseModel.fromJson(Map<String, dynamic> json) {
    return EventInvitationResponseModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        error: json["error"],
        success: json["success"]);
  }
}
