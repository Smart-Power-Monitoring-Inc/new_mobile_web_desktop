import 'dart:developer';

import 'package:admin/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashbaordParamsController with ChangeNotifier {
  Stream voltageStream() async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Response response = await Dio()
          .get(baseUrl + "summary/${prefs.getString('uid')}/voltage");

      yield response.data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Stream currentStream() async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await Dio()
          .get(baseUrl + "summary/${prefs.getString('uid')}/current");

      yield response.data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Stream amountStream() async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await Dio().get(baseUrl +
          "summary/${prefs.getString('uid')}/energy"); // Remember to fix this
      print(response.data);
      yield response.data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Stream energyStream() async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response =
          await Dio().get(baseUrl + "summary/${prefs.getString('uid')}/energy");

      yield response.data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Stream powerStream() async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response =
          await Dio().get(baseUrl + "summary/${prefs.getString('uid')}/power");

      yield response.data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
