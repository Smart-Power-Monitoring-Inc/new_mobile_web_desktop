import 'package:admin/helper.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;
  bool voltage, current, energy, consumption;

  CloudStorageInfo(
      {this.svgSrc,
      this.title,
      this.totalStorage,
      this.numOfFiles,
      this.percentage,
      this.color,
      this.consumption = false,
      this.current = false,
      this.energy = false,
      this.voltage = false});
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "GH¢ Used",
    numOfFiles: 1328,
    svgSrc: Img.get("money-bag.png"),
    totalStorage: "GH¢",
    color: primaryColor,
    consumption: true,
    percentage: 35,
  ),
  CloudStorageInfo(
      title: "Energy",
      numOfFiles: 1328,
      svgSrc: Img.get("energy-drink.png"),
      totalStorage: "kWH",
      color: Color(0xFFFFA113),
      percentage: 35,
      energy: true),
  CloudStorageInfo(
      title: "Voltage",
      numOfFiles: 1328,
      svgSrc: Img.get("high-voltage.png"),
      totalStorage: "V (Volts)",
      color: Color(0xFFA4CDFF),
      percentage: 10,
      voltage: true),
  CloudStorageInfo(
      title: "Current",
      numOfFiles: 5328,
      svgSrc: Img.get("electric-current.png"),
      totalStorage: "A (Ampere)",
      color: Color(0xFF007EE5),
      percentage: 78,
      current: true),
];
