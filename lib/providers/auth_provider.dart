import 'package:flutter/material.dart';
import 'package:safe_entry/constants.dart';
import 'package:safe_entry/models/login_model.dart';
import 'package:safe_entry/models/register_model.dart';
import 'package:safe_entry/resources/EnumApiRequests.dart';
import 'package:safe_entry/services/API_Client.dart';
import 'package:safe_entry/services/app_preferences.dart';

final urlApi = url;
String? token;

class AuthProvider with ChangeNotifier {
  APIClient _apiClient = APIClient();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    try {
      setLoading(true);
      String url = urlApi + '/Auth/login';
      var response =
          await _apiClient.request(API_REQUEST.POST, url, requestModel);

      var responseData = LoginResponseModel.fromJson(response);
      token = responseData.token;
      AppPreferences.storeToken(token!);
      return responseData;
    } catch (e) {
      print(e);
      setLoading(false);
      return LoginResponseModel();
    }
  }

  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    try {
      String url = urlApi + '/auth/register/';
      var response =
          await _apiClient.request(API_REQUEST.POST, url, requestModel);

      var responseData = RegisterResponseModel.fromJson(response);
      return responseData;
    } catch (e) {
      return RegisterResponseModel();
    }
  }
}
