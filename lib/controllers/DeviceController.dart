import 'dart:async';
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
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Response response =
          await Dio().get(baseUrl + 'device_search/${prefs.getString("uid")}');
      // print(response.data);
      // print("Device data:  " + response.data['result'].toString());
      if (response.data['result'].isNotEmpty) {
        return [
          true,
          response.data['result']
              .map((device) => Device(
                      name: device['device_name'] ?? "",
                      uid: device['device_uid'] ?? "",
                      active: device['state'],
                      currentrating: double.parse(
                          device['readings'].last['reading'].toString()),
                      readings: <DeviceReading>[
                        ...device['readings']
                            .map((e) => DeviceReading(
                                time: DateTime.parse(e['timestamp']),
                                value: double.parse(e['reading'].toString())))
                            .toList()
                      ]))
              .toList()
        ];
      } else {
        return [false, []];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [false, []];
    }
  }

  void initTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      notifyListeners();
    });
  }

  Stream<Map<String, dynamic>> getOnlineDevices(bool online) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String uid = prefs.getString("uid") ?? "";

      Response response =
          await Dio().get(baseUrl + 'device_search/$uid/g?online=$online');
      // debugPrint("Device status request: ${response.data}");
      yield response.data as Map<String, dynamic>;
    } catch (e) {
      debugPrint("an error occured: $e");
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

  Future toggleDevice(String uid) async {
    // Make a post request to backend update device status

    try {
      Response response =
          await Dio().post("${routerUrl}toogle", data: {"uid": uid});
      return response.data;
    } catch (e) {
      log("Toggle response: $e");
      throw Exception(e);
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
