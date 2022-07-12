import 'dart:io';

import 'package:admin/screens/devices/QRCode.dart';
import 'package:admin/screens/devices/verifyDevice.dart';
import 'package:flutter/material.dart';

void newDevice(BuildContext context, TextEditingController controller) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Platform.isIOS || Platform.isAndroid
                            ? Text(
                                "Scan device QR Code or enter the device id in the textfield below")
                            : Text(
                                "Enter smart socket id to register the device")),
                    Platform.isIOS || Platform.isAndroid
                        ? QRCodeView()
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Device Id",
                            hintText: "Device Id",
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a value";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    verifyDeviceText(context, controller.text);
                  },
                  child: Text("Okay"))
            ],
          ));
}
