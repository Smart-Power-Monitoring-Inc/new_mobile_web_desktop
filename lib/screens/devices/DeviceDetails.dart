import 'package:admin/constants.dart';
import 'package:admin/controllers/DeviceController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/devices/DeviceChart.dart';
import 'package:admin/screens/devices/DeviceDetailsComponent.dart';
import 'package:flutter/material.dart';

class DeviceDetails extends StatelessWidget {
  final Device device;
  const DeviceDetails({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Device Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
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
                  onPressed: () {},
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
