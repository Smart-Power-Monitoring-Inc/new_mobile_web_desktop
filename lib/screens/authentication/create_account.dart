import 'package:admin/constants.dart';
import 'package:admin/controllers/AuthController.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final List<String> images = ["1.jpg", "2.jpg", "3.jpg"];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController phone, pincode, name;
  String countryCode = "";

  @override
  void initState() {
    phone = TextEditingController();
    pincode = TextEditingController();
    name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    pincode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text("Create Account"),
      ),
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Phone number is required";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
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
                        controller: name,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          hintText: "Full name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        controller: pincode,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Pincode is required";
                          }
                          return null;
                        },
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthController>().create(
                                    context,
                                    countryCode: countryCode,
                                    phone: phone.text,
                                    name: name.text,
                                    pin: pincode.text,
                                  );
                            }
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context, '/', (route) => false);
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
                                  "Create account",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                ),
                              )))
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
