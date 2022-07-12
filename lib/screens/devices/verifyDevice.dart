import 'dart:developer';

import 'package:admin/constants.dart';
import 'package:admin/screens/devices/loading.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

void verifyDeviceQR(
    BuildContext context, QRViewController controller, String? code) {
  // Make a request to the backend to register the device
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Scanned code " + code.toString())));
  showLoading(context);
  controller.pauseCamera();
  Future.delayed(const Duration(seconds: 1), () {
    ScaffoldMessenger.of(context).clearSnackBars();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  });
}

void verifyDeviceText(BuildContext context, String code) async {
  // Make a requset to the backend to resigster the device

  showLoading(context);
  Map<String, dynamic> response = await sendDeviceToRegisterRequest(id: code);
  if (response['stat']) {
    Navigator.pop(context);
    CoolAlert.show(
        context: context, type: CoolAlertType.error, text: response['msg']);
    return;
  }
  CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: "Smart socket added successfully");
  Future.delayed(const Duration(seconds: 1), () {
    Navigator.pop(context);
  });
}

Future<Map<String, dynamic>> sendDeviceToRegisterRequest({
  required String id,
}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountUID = prefs.getString("uid");
    if (id.isEmpty) {
      log('Account UID is null. Please enter an account id or scan the Smart socket\'s QRCode');
      return {
        "stat": true,
        "msg":
            'Account UID is null. Please enter an account id or scan the Smart socket\'s QRCode'
      };
    }
    print(id);
    Response response =
        await Dio().post(baseUrl + "device_search/add/$id/$accountUID");

    return response.data;
  } catch (e) {
    log(e.toString());
    return {"stat": true, "msg": "An error occured"};
  }
}
