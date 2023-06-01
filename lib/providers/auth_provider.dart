import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(String email, String password) async {
    try {
      setLoading(true);
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        setLoading(false);
        print('succesfully');
      } else {
        setLoading(false);
        print('failed');
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }
}
