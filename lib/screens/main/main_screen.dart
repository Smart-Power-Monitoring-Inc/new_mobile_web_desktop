import 'dart:io';

import 'package:admin/constants.dart';
import 'package:admin/controllers/PageController.dart';
import 'package:admin/controllers/UserController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/devices/ManageDevices.dart';
import 'package:admin/screens/devices/newDevice.dart';
import 'package:admin/screens/settings/Settings.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController controllerText;
  void showWelcomeNote(String name) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: "Welcome",
        text: "Welcome back $name!",
        animType: CoolAlertAnimType.scale,
        backgroundColor: white,
        autoCloseDuration: Duration(seconds: 2));
  }

  @override
  void initState() {
    controllerText = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // User user = await context.read<UserController>().getUser();
      // Future.delayed(Duration(seconds: 1), () => showWelcomeNote(user.name));
    });
  }

  // int? pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<UserController>().getUser(context),
        builder: (context, snapshot) {
          return Scaffold(
            drawer: SideMenu(),
            floatingActionButton: (Platform.isAndroid || Platform.isIOS)
                ? FutureBuilder<int?>(
                    future: Provider.of<MyPageController>(context).page,
                    builder: (context, snapshot) {
                      print("here");
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      int? page = snapshot.data;

                      return page == 1
                          ? FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () =>
                                  newDevice(context, controllerText),
                              child: Icon(Icons.add),
                            )
                          : Container();
                    })
                : null,
            body: SafeArea(
              child: FutureBuilder<int?>(
                  future: Provider.of<MyPageController>(context).page,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    int? page = snapshot.data;

                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
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
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
