import 'package:flutter/material.dart';
import 'package:safe_entry/constants.dart';
import 'package:safe_entry/models/login_model.dart';
import 'package:safe_entry/resources/EnumApiRequests.dart';
import 'package:safe_entry/services/API_Client.dart';

final urlApi = url;

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
      String url = urlApi + '/auth/login/';
      var response =
          await _apiClient.request(API_REQUEST.POST, url, requestModel);

      var responseData = LoginResponseModel.fromJson(response);
      // token = responseData.token;
      // AppPreferences.storeToken(token!);
      return responseData;
    } catch (e) {
      print(e);
      setLoading(false);
      return LoginResponseModel();
    }
  }
}
