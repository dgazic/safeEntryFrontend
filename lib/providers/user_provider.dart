import 'package:flutter/cupertino.dart';
import 'package:safe_entry/constants.dart';
import 'package:safe_entry/models/user_model.dart';
import 'package:safe_entry/resources/EnumApiRequests.dart';
import 'package:safe_entry/services/API_Client.dart';
import 'package:safe_entry/services/jwt_decoder.dart';

final urlApi = url;
String? token;
APIClient _apiClient = APIClient();

class UserProvider with ChangeNotifier {
  Future<List<UserResponseModel>> fetchUsers() async {
    try {
      final String userRoleId = jwtDecoder().getToken()['UserRoleId'];

      String url = urlApi + '/user/GetUsers/';
      Map<String, dynamic>? qParam = {"userRoleId": userRoleId};
      var response = await _apiClient.request(API_REQUEST.GET, url, null,
          queryParameters: qParam);
      return response["userModelDto"]
          .map<UserResponseModel>((json) => UserResponseModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Fail to retrieve users');
    }
  }
}
