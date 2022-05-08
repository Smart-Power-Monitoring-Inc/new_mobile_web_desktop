import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }
}
