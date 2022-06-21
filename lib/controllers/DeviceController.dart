import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

List<Device> _deviceList = [];

class DeviceController with ChangeNotifier {
  get returnDeviceList {
    return [..._deviceList];
  }

  Future<List> get getDeviceData async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Response response =
        await Dio().get(baseUrl + 'device_search/${prefs.getString("uid")}');

    print("Device data:  " + response.data['result']['devices'].toString());
    if (response.data['result']['devices'].isNotEmpty) {
      return [
        true,
        response.data['result']['devices']
            .map((device) => Device(
                name: device['device_name'],
                uid: device['device_uid'],
                currentrating: 0,
                readings: []))
            .toList()
      ];
    } else {
      return [false, []];
    }
  }

  Stream<List> get getOnlineDevices async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Response response = await Dio()
        .get(baseUrl + 'device_search/${prefs.getString("uid")}/g?online=true');
    log(response.data.toString());
    yield [];
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
