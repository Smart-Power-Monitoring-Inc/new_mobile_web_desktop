import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:admin/models/User.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController with ChangeNotifier {
  // get user data from db
  Future<User> getUser(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    Map<String, dynamic> userJson = jsonDecode(user as String);

    return User(
        email: userJson['email'],
        name: userJson['name'],
        phone: userJson['phone'],
        uid: uid);
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
