import 'dart:convert';
import 'dart:developer';

import 'package:admin/constants.dart';
import 'package:admin/models/User.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class UserController with ChangeNotifier {
  // get user data from db
  bool error = false;
  Future<User> get returnUser async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? user = prefs.getString('user') ?? {}.toString();

      Map<String, dynamic> userJson = jsonDecode(user);

      notifyListeners();
      return User(
          email: userJson['email'],
          name: userJson['f_name'],
          phone: userJson['phone'],
          uid: userJson['id']);
    } catch (e) {
      debugPrint("User fetch error: $e");
      rethrow;
    }
  }

  Future<User> getUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint("User id: ${prefs.getString("uid")}");
      Response response =
          await Dio().get(baseUrl + 'user_data/${prefs.getString("uid")}');
      // debugPrint(response.data.toString());
      // String? user = prefs.getString('user');
      Map<String, dynamic> userJson = response.data['userDetails'];
      await prefs.setString('user', jsonEncode(userJson));
      notifyListeners();
      error = false;
      if (response.data['name'] == null) {
        error = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.data['msg'])));
      }
      return User(
          email: userJson['email'],
          name: userJson['f_name'],
          phone: userJson['phone'],
          uid: userJson['id']);
    } catch (e) {
      log("User fetch error: $e");
      // debugPrint(e.toString());
      // errorWidget(context);
      error = true;
      throw Exception(e);
    }
  }

  void errorWidget(BuildContext context) {
    if (error) return;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Color(0xffffeb00),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: SizedBox(
                  child: Image.asset(
                    Img.get("error.png"),
                    fit: BoxFit.contain,
                    height: 300,
                    width: 300,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Backend Unreachable",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: black, shape: StadiumBorder()),
                onPressed: () {
                  notifyListeners();
                  Navigator.pop(context);
                  getUser(context);
                  error = false;
                },
                child: Text(
                  "Reload",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold, color: white),
                ))
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> createUser(User user) async {
    // make a post request to the db
    Response response = await Dio().post("$baseUrl/user/create-");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return {
        "error": true,
        "message": "Something went wrong. Please try again later."
      };
    }
  }

  void setUser(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(uid));
    notifyListeners();
  }
}
