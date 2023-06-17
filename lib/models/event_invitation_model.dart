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
  final String? error;
  bool? success;

  EventInvitationResponseModel({this.error, this.success});

  factory EventInvitationResponseModel.fromJson(Map<String, dynamic> json) {
    return EventInvitationResponseModel(
        error: json["error"], success: json["success"]);
  }
}
