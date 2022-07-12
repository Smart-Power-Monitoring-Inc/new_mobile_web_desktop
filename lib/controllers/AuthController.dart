import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Future<bool> create(
    BuildContext context, {
    required String name,
    required String phone,
    required String pin,
    required String countryCode,
  }) async {
    // Dio().post("path",)
    try {
      Response response = await Dio().post(baseUrl + "new/create/",
          data: jsonEncode({
            "f_name": name,
            "phone": phone,
            "password": pin,
            "country_code": countryCode
          }));
      debugPrint(response.data.toString());
      if (response.data["stat"]) {
        Navigator.pop(context);
        return true;
      }
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          text: response.data["msg"]);
      return response.data["stat"] ?? false;
    } catch (e) {
      debugPrint("Login error: $e");
      rethrow;
    }
  }

  Future<bool> login(
    BuildContext context, {
    required String phone,
    required String pin,
    required String countryCode,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await Dio().post(baseUrl + "new/access/",
          data: jsonEncode({
            "phone": countryCode + phone,
            "pin": pin,
            "country_code": countryCode
          }));
      debugPrint(response.data.toString());
      if (response.data["stat"]) {
        await prefs.setString("uid", response.data["id"]);
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Error",
            text: response.data["msg"]);
      }
      return response.data["stat"] ?? false;
    } catch (e) {
      debugPrint("Login error: $e");
      rethrow;
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", "");
    Navigator.pushReplacementNamed(context, "/login");
  }
}
