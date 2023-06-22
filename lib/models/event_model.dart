class EventRegistrationRequestModel {
  String? eventName;
  String? eventDescription;
  String? eventAddress;
  String? eventStarts;
  int? eventOrganizerId;

  EventRegistrationRequestModel(
      {this.eventName,
      this.eventDescription,
      this.eventAddress,
      this.eventStarts,
      this.eventOrganizerId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'eventName': eventName!,
      'eventDescription': eventDescription,
      'eventAddress': eventAddress,
      'eventStarts': eventStarts,
      'eventOrganizerId': eventOrganizerId,
    };

    return map;
  }
}

class EventRegistrationResponseModel {
  final String? error;
  bool? success;

  EventRegistrationResponseModel({this.error, this.success});

  factory EventRegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return EventRegistrationResponseModel(
        error: json["error"], success: json["success"]);
  }
}

class EventResponseModel {
  int? Id;
  String? Name;
  String? Description;
  String? Address;
  String? EventStarts;
  int? eventOrganizerId;
  String? companyName;
  int? PeopleInvited;

  EventResponseModel(
      {this.Id,
      this.Name,
      this.Description,
      this.Address,
      this.EventStarts,
      this.eventOrganizerId,
      this.PeopleInvited,
      this.companyName});

  factory EventResponseModel.fromJson(Map<String, dynamic> json) {
    return EventResponseModel(
        Id: json["id"],
        Name: json["name"],
        Description: json["description"],
        Address: json["address"],
        EventStarts: json["eventStarts"],
        PeopleInvited: json["peopleInvited"],
        companyName: json["companyName"]);
  }
}
