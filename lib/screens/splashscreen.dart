import 'package:admin/constants.dart';
import 'package:admin/screens/authentication/authentication.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("uid");
      print(token == null);
      if (token != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("This page is called");
    return AnimatedSplashScreen(
      backgroundColor: secondaryColor,
      nextScreen: Authentication(),
      centered: true,
      splash: Img.get("knust.png"),
    );
  }
}
