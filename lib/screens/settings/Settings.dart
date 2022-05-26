import 'dart:io';

import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool appNotifications = false;
  bool smsNotifications = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(children: [
          Header(),
          SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 5,
                  child: FractionallySizedBox(
                    // heightFactor: 1,
                    widthFactor: Responsive.isMobile(context) ? 1 : 0.4,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Account",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            ListTile(
                              leading: Icon(Icons.account_circle_outlined),
                              title: Text(
                                "Edit Profile",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_forward_ios
                                    : Icons.arrow_forward,
                                size: 15,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.lock_outline_rounded),
                              title: Text(
                                "Change Pin",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_forward_ios
                                    : Icons.arrow_forward,
                                size: 15,
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Notifications",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SwitchListTile.adaptive(
                              value: smsNotifications,
                              onChanged: (value) {
                                setState(() {
                                  smsNotifications = value;
                                });
                              },
                              title: Text(
                                "SMS Notifications",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SwitchListTile.adaptive(
                              value: appNotifications,
                              onChanged: (value) {
                                setState(() {
                                  appNotifications = value;
                                });
                              },
                              title: Text(
                                "App Notifications",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "More",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            ListTile(
                              leading: Icon(Icons.privacy_tip_outlined),
                              title: Text(
                                "Privacy",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_forward_ios
                                    : Icons.arrow_forward,
                                size: 15,
                              ),
                              onTap: () => launchUrlString(
                                  "https://github.com/asare-21/privacy_policy"),
                            ),
                            ListTile(
                              leading: Icon(Icons.info),
                              title: Text(
                                "About Us",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_forward_ios
                                    : Icons.arrow_forward,
                                size: 15,
                              ),
                              onTap: () => launchUrlString(
                                  "https://keep-project.herokuapp.com/#about"),
                            ),
                            Divider(),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            height: 50,
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )
                      ],
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
