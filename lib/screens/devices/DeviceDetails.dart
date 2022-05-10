import 'dart:io';

import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/devices/DeviceChart.dart';
import 'package:admin/screens/devices/DeviceDetailsComponent.dart';
import 'package:admin/screens/devices/QRCode.dart';
import 'package:flutter/material.dart';

class DeviceDetails extends StatelessWidget {
  // final Device device;
  const DeviceDetails({
    Key? key,
    //  required this.device
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white);

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Device Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () {
                    // show device profile popup
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text("Device Profile"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Okay"))
                            ],
                            content: SizedBox(
                                height: 300,
                                child: Scrollbar(
                                  isAlwaysShown: true,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text("Device name"),
                                          subtitle: Text(
                                            "Room Main Socket",
                                            style: style,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("Rating (A)"),
                                          subtitle: Text("30A", style: style),
                                        ),
                                        ListTile(
                                          title: Text("Total Power (kW)"),
                                          subtitle: Text("30 kW", style: style),
                                        ),
                                        ListTile(
                                          title: Text("Total Energy (kWh)"),
                                          subtitle:
                                              Text("30 kWh", style: style),
                                        ),
                                        ListTile(
                                          title: Text("Total uptime"),
                                          subtitle:
                                              Text("00:10:22:14", style: style),
                                        ),
                                        ListTile(
                                          title: Text("Last seen"),
                                          subtitle: Text("Date", style: style),
                                        ),
                                        ListTile(
                                          title: Text("Date added"),
                                          subtitle: Text("Date", style: style),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))));
                  },
                  icon: Icon(Icons.more_vert_outlined))
            ],
          ),
          SizedBox(height: defaultPadding),
          DeviceChart(),
          DeviceDetailsCard(
            svgSrc: "high-voltage.png",
            title: "Voltage",
            amountOfFiles: "V",
            numOfFiles: 238,
          ),
          DeviceDetailsCard(
            svgSrc: "electric-current.png",
            title: "Current",
            amountOfFiles: "A",
            numOfFiles: 13.5,
          ),
          DeviceDetailsCard(
            svgSrc: "energy-drink.png",
            title: "Power (kW)",
            amountOfFiles: "KW",
            numOfFiles: 1328,
          ),
          DeviceDetailsCard(
            svgSrc: "energy-drink.png",
            title: "Energy (kWH)",
            amountOfFiles: "KWH",
            numOfFiles: 140,
          ),
          SizedBox(
            height: 100,
          ),
          !Responsive.isMobile(context)
              ? ElevatedButton(
                  onPressed: () {
                    // Show dialog with the qrscanner built in (if on mobile) and text field
                    // Show only input field if on web or desktop

                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Platform.isIOS ||
                                              Platform.isAndroid
                                          ? Text(
                                              "Scan device QR Code or enter the device id in the textfield below")
                                          : Text(
                                              "Enter smart socket id to register the device")),
                                  Platform.isIOS || Platform.isAndroid
                                      ? QRCodeView()
                                      : Container(),
                                  TextFormField(
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
                                  )
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Okay"))
                              ],
                            ));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: white,
                      padding: const EdgeInsets.all(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: black,
                        ),
                        Text(
                          "New Device",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold, color: black),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
