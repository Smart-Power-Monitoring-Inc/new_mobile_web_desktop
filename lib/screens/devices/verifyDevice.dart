import 'package:admin/screens/devices/loading.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void verifyDeviceQR(
    BuildContext context, QRViewController controller, String? code) {
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

void verifyDeviceText(BuildContext context, String? code) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Scanned code " + code.toString())));
  showLoading(context);
  // controller.pauseCamera();
  Future.delayed(const Duration(seconds: 1), () {
    ScaffoldMessenger.of(context).clearSnackBars();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  });
}
