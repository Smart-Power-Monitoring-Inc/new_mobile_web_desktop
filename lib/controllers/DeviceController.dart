import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceController with ChangeNotifier {
  Future<List> get getDeviceData async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> deviceData =
        jsonDecode(prefs.getString('/device/uid').toString());
    if (deviceData.isNotEmpty) {
      notifyListeners();
      return [
        true,
        Device(
            name: deviceData['name'],
            uid: deviceData['uid'],
            currentrating: deviceData['currentrating'],
            readings: deviceData['readings'])
      ];
    } else {
      return [false];
    }
  }
}

class Device {
  String name, uid;
  double currentrating;
  List<DeviceReading> readings;
  bool active;
  String dateAdded;

  Device(
      {required this.name,
      required this.uid,
      required this.currentrating,
      required this.readings,
      this.dateAdded = "",
      this.active = false});
}

class DeviceReading {
  DateTime time;
  double value;

  DeviceReading({required this.time, required this.value});
}
