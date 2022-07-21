import 'package:admin/helper.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  double? numOfFiles;
  int? percentage;
  final Color? color;
  String type;
  bool voltage, current, energy, consumption;

  CloudStorageInfo(
      {this.svgSrc,
      this.title,
      this.totalStorage,
      this.numOfFiles,
      this.percentage,
      this.color,
      this.consumption = false,
      required this.type,
      this.current = false,
      this.energy = false,
      this.voltage = false});
}

List<CloudStorageInfo> demoMyFiles = [
  CloudStorageInfo(
      title: "GH¢ Used",
      numOfFiles: 1328.0,
      svgSrc: Img.get("money-bag.png"),
      totalStorage: "GH¢",
      color: primaryColor,
      consumption: true,
      percentage: 35,
      type: "amount"),
  CloudStorageInfo(
      title: "Energy",
      numOfFiles: 1328.0,
      svgSrc: Img.get("energy-drink.png"),
      totalStorage: "kWH",
      color: Color(0xFFFFA113),
      percentage: 35,
      energy: true,
      type: "energy"),
  CloudStorageInfo(
      title: "Voltage",
      numOfFiles: 1328.0,
      svgSrc: Img.get("high-voltage.png"),
      totalStorage: "V (Volts)",
      color: Color(0xFFA4CDFF),
      percentage: 10,
      voltage: true,
      type: "voltage"),
  CloudStorageInfo(
      title: "Power",
      numOfFiles: 1328.0,
      svgSrc: Img.get("high-voltage.png"),
      totalStorage: "kW (Kilowatts)",
      color: Color(0xFFA4CDFF),
      percentage: 10,
      voltage: true,
      type: "power"),
  CloudStorageInfo(
      title: "Current",
      numOfFiles: 5328.0,
      svgSrc: Img.get("electric-current.png"),
      totalStorage: "A (Ampere)",
      color: Color(0xFF007EE5),
      percentage: 78,
      type: "current",
      current: true),
];
