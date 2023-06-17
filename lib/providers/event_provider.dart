import 'package:flutter/material.dart';
import 'package:safe_entry/constants.dart';
import 'package:safe_entry/models/event_invitation_model.dart';
import 'package:safe_entry/models/event_model.dart';
import 'package:safe_entry/resources/EnumApiRequests.dart';
import 'package:safe_entry/services/API_Client.dart';
import 'package:safe_entry/services/jwt_decoder.dart';

final urlApi = url;
String? token;

class EventProvider with ChangeNotifier {
  APIClient _apiClient = APIClient();

  Future<EventRegistrationResponseModel> EventRegistration(
      EventRegistrationRequestModel requestModel) async {
    try {
      String url = urlApi + '/Event/EventRegistration/';
      var response =
          await _apiClient.request(API_REQUEST.POST, url, requestModel);

      var responseData = EventRegistrationResponseModel.fromJson(response);
      return responseData;
    } catch (e) {
      return EventRegistrationResponseModel();
    }
  }

  Future<List<EventResponseModel>> fetchEvents() async {
    try {
      final String userId = jwtDecoder().getToken()['UserId'];

      String url = urlApi + '/Event/GetEvents/';
      Map<String, dynamic>? qParam = {"organizerId": userId};
      var response = await _apiClient.request(API_REQUEST.GET, url, null,
          queryParameters: qParam);
      return response["eventsDto"]
          .map<EventResponseModel>((json) => EventResponseModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Fail to retrieve events');
    }
  }

  Future<EventInvitationResponseModel> PeopleRegistrationEvent(
      EventInvitationRequestModel requestModel) async {
    try {
      String url = urlApi + '/Event/PeopleRegistrationEvent/';
      var response =
          await _apiClient.request(API_REQUEST.POST, url, requestModel);

      var responseData = EventInvitationResponseModel.fromJson(response);
      return responseData;
    } catch (e) {
      return EventInvitationResponseModel();
    }
  }
}
