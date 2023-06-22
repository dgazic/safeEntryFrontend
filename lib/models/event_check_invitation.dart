class EventCheckInvitationRequestModel {
  int? eventId;
  String? invitationCode;

  EventCheckInvitationRequestModel({this.eventId, this.invitationCode});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'eventId': eventId,
      'invitationCode': invitationCode!
    };

    return map;
  }
}

class EventCheckInvitationResponseModel {
  final String? error;
  bool? success;

  EventCheckInvitationResponseModel({this.error, this.success});

  factory EventCheckInvitationResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EventCheckInvitationResponseModel(
        error: json["error"], success: json["success"]);
  }
}
