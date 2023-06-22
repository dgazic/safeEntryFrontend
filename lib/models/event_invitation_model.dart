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
  int? id;
  String? firstName;
  String? lastName;
  bool? active;
  final String? error;
  bool? success;

  EventInvitationResponseModel(
      {this.firstName,
      this.lastName,
      this.error,
      this.success,
      this.id,
      this.active});

  factory EventInvitationResponseModel.fromJson(Map<String, dynamic> json) {
    return EventInvitationResponseModel(
        id: json["id"],
        active: json["active"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        error: json["error"],
        success: json["success"]);
  }
}
