import 'package:flutter/material.dart';
import 'package:safe_entry/constants.dart';
import 'package:safe_entry/models/event_check_invitation.dart';
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

  Future<List<EventResponseModel>> fetchEventsByOrganization() async {
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

  Future<List<EventResponseModel>> fetchEvents() async {
    try {
      String url = urlApi + '/Event/GetEvents/';
      var response = await _apiClient.request(API_REQUEST.GET, url, null);
      return response["eventsDto"]
          .map<EventResponseModel>((json) => EventResponseModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Fail to retrieve events');
    }
  }

  Future<EventResponseModel> fetchEventById(int eventId) async {
    try {
      String url = urlApi + '/Event/EventById/';
      Map<String, dynamic>? qParam = {"eventId": eventId};
      var response = await _apiClient.request(API_REQUEST.GET, url, null,
          queryParameters: qParam);
      var responser = response['eventDto'];
      var responseData = EventResponseModel.fromJson(responser);
      return responseData;
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

  Future<List<EventInvitationResponseModel>> GetInvitedPeopleEvent(
      int eventId) async {
    try {
      String url = urlApi + '/Event/GetInvitedPeopleEvent/';
      Map<String, dynamic>? qParam = {"eventId": eventId};
      var response = await _apiClient.request(API_REQUEST.GET, url, null,
          queryParameters: qParam);
      return response["eventsInvitationDto"]
          .map<EventInvitationResponseModel>(
              (json) => EventInvitationResponseModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Fail to retrieve events');
    }
  }

  Future<EventCheckInvitationResponseModel> CheckInvitationCode(
      EventCheckInvitationRequestModel eventInvitationRequestModel) async {
    try {
      String url = urlApi + '/Event/ScanQrCode/';
      var response = await _apiClient.request(
          API_REQUEST.POST, url, eventInvitationRequestModel);
      var responser = response;
      var responseData = EventCheckInvitationResponseModel.fromJson(responser);
      return responseData;
    } catch (e) {
      throw Exception('Fail to retrieve events');
    }
  }
}
