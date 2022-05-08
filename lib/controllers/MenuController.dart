import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MenuController extends ChangeNotifier {
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMeu(BuildContext context) {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
