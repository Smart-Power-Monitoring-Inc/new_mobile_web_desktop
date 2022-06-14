import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/devices/DeviceDetails.dart';
import 'package:admin/screens/devices/DeviceList.dart';
import 'package:flutter/material.dart';

class ManageDevicesScreen extends StatelessWidget {
  const ManageDevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Header(),
          SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    DeviceList(),
                    if (Responsive.isMobile(context))
                      SizedBox(height: defaultPadding),
                    if (Responsive.isMobile(context)) DeviceDetails(),
                  ],
                ),
              ),
              if (!Responsive.isMobile(context))
                Expanded(flex: 2, child: DeviceDetails())
            ],
          )
        ]),
      ),
    );
  }
}
