import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageController with ChangeNotifier {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<int?> get page async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("page") ?? 0;
  }

  void setPage(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("page", page);
    notifyListeners();
  }
}
