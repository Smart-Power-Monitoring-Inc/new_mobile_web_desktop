import 'package:admin/constants.dart';
import 'package:admin/screens/authentication/authentication.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: secondaryColor,
      nextScreen: Authentication(),
      centered: true,
      splash: Img.get("knust.png"),
    );
  }
}
