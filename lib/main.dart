import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/NetworkController.dart';
import 'package:admin/controllers/PageController.dart';
import 'package:admin/screens/authentication/authentication.dart';
import 'package:admin/screens/authentication/create_account.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/profile/confirmPhone.dart';
import 'package:admin/screens/profile/profile.dart';
import 'package:admin/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'controllers/AuthController.dart';
import 'controllers/UserController.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MenuController(),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthController(),
    ),
    ChangeNotifierProvider(
      create: (context) => MyPageController(),
    ),
    ChangeNotifierProvider(
      create: (context) => NetworkController(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserController(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Keep',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.openSansTextTheme().apply(bodyColor: white),
          canvasColor: secondaryColor,
        ),
        initialRoute: "/splash",
        routes: {
          "/login": (context) => Authentication(),
          "/": (context) => MainScreen(),
          "/splash": (context) => SplashScreen(),
          "/profile": (context) => MyProfile(),
          "/confirm": (context) => ConfirmPhone(),
          "/create": (context) => CreateAccount(),
        });
  }
}
