import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:admin/models/User.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController with ChangeNotifier {
  // get user data from db
  Future<User> get returnUser async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? user = prefs.getString('user') ?? {}.toString();
      Map<String, dynamic> userJson = jsonDecode(user);

      notifyListeners();
      return User(
          email: userJson['email'],
          name: userJson['f_name'],
          phone: userJson['phone'],
          uid: userJson['id']);
    } catch (e) {
      debugPrint("User fetch error: $e");
      rethrow;
    }
  }

  Future<User> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response =
          await Dio().get(baseUrl + 'user_data/${prefs.getString("uid")}');
      debugPrint(response.data.toString());
      // String? user = prefs.getString('user');
      Map<String, dynamic> userJson = response.data['userDetails'];
      await prefs.setString('user', jsonEncode(userJson));
      notifyListeners();
      return User(
          email: userJson['email'],
          name: userJson['f_name'],
          phone: userJson['phone'],
          uid: userJson['id']);
    } catch (e) {
      debugPrint("User fetch error: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createUser(User user) async {
    // make a post request to the db
    Response response = await Dio().post("$baseUrl/user/create-");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return {
        "error": true,
        "message": "Something went wrong. Please try again later."
      };
    }
  }

  void setUser(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(uid));
    notifyListeners();
  }
}
