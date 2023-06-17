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
  String? Starts;
  int? eventOrganizerId;

  EventResponseModel({
    this.Id,
    this.Name,
    this.Description,
    this.Address,
    this.Starts,
    this.eventOrganizerId,
  });

  factory EventResponseModel.fromJson(Map<String, dynamic> json) {
    return EventResponseModel(
        Id: json["id"],
        Name: json["name"],
        Description: json["description"],
        Address: json["address"],
        Starts: json["starts"]);
  }
}
