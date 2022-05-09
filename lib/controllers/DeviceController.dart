import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Device> _deviceList = [];

class DeviceController with ChangeNotifier {
  get returnDeviceList {
    return [..._deviceList];
  }

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

  Future<Device> getSelectdDevice(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDeviceString = prefs.getString("selectedDevice") ?? "{}";
    Map<String, dynamic> selectedDeviceMap = jsonDecode(selectedDeviceString);
    return Device(
        name: selectedDeviceMap['name'],
        uid: selectedDeviceMap['uid'],
        currentrating: selectedDeviceMap['currentrating'],
        readings: selectedDeviceMap['readings'],
        dateAdded: selectedDeviceMap['dateAdded']);
  }

  Future<void> selectDevice(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Device selectedDevice = _deviceList[index];
    Map<String, dynamic> deviceMap = {
      "name": selectedDevice.name,
      "uid": selectedDevice.uid,
      "currentrating": selectedDevice.currentrating,
      "readings": selectedDevice..readings,
      "dateAdded": selectedDevice.dateAdded
    };
    prefs.setString("selectedDevice",
        jsonEncode(deviceMap)); // save the selected device in memory
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
