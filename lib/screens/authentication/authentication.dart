import 'package:admin/constants.dart';
import 'package:admin/controllers/AuthController.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final List<String> images = ["1.jpg", "2.jpg", "3.jpg"];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController phone, pincode;
  String countryCode = "";

  @override
  void initState() {
    phone = TextEditingController();
    pincode = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Image.asset(Img.get("knust.png")),
                      Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                searchAutofocus: true,
                                countryListTheme: CountryListThemeData(
                                    borderRadius: BorderRadius.circular(5),
                                    backgroundColor: white,
                                    inputDecoration: InputDecoration(
                                      filled: true,
                                      fillColor: black,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: black),
                                    ),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: black)),
                                onSelect: (country) {
                                  setState(() {
                                    countryCode = country.phoneCode;
                                  });
                                });
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      countryCode.isEmpty
                                          ? "+ Add"
                                          : "+$countryCode",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: lightGrey),
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: phone,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty && countryCode.isEmpty) {
                                      return "Phone number is required. Kindly select a country";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Phone",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        controller: pincode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Pincode is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          hintText: "Pin code",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate())
                              context.read<AuthController>().login(context,
                                  phone: phone.text,
                                  pin: pincode.text,
                                  countryCode: countryCode);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(5)),
                          child: SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                ),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, "/create"),
                        child: Text(
                          "Don't have an account? Create one",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  decoration: TextDecoration.underline,
                                  color: blue),
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
