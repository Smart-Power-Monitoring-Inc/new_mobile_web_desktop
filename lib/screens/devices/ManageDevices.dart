import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/devices/DeviceDetails.dart';
import 'package:flutter/material.dart';

class ManageDevicesScreen extends StatelessWidget {
  const ManageDevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(children: [
          Header(),
          SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Container(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) DeviceDetails(),
                    ],
                  )),
              if (!Responsive.isMobile(context))
                Expanded(flex: 2, child: DeviceDetails())
            ],
          )
        ]),
      ),
    );
  }
}
