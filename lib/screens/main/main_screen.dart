import 'package:admin/controllers/PageController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/devices/ManageDevices.dart';
import 'package:admin/screens/settings/Settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: FutureBuilder<int?>(
            future: Provider.of<MyPageController>(context).page,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              int? page = snapshot.data;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    Expanded(
                      // default flex = 1
                      // and it takes 1/6 part of the screen
                      child: SideMenu(),
                    ),
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 5,
                    child: page == 0
                        ? DashboardScreen()
                        : page == 1
                            ? ManageDevicesScreen()
                            : SettingsScreen(),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
