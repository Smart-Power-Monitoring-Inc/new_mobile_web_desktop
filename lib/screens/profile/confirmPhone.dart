import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../responsive.dart';

class ConfirmPhone extends StatefulWidget {
  ConfirmPhone({Key? key}) : super(key: key);

  @override
  State<ConfirmPhone> createState() => _ConfirmPhoneState();
}

class _ConfirmPhoneState extends State<ConfirmPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Number",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: bgColor,
              child: Column(children: [
                Text(
                  "Confirm your phone number",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Container(height: 10),
                Text(
                  "We will send a verification code to this number",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                ),
                Container(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("$value"),
                    ));
                  },
                ),
                Container(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Enter confirmation code received",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 270,
                  child: PinCodeTextField(
                    appContext: context,
                    enablePinAutofill: true,
                    enableActiveFill: true,
                    cursorColor: white,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    blinkWhenObscuring: true,
                    pinTheme: PinTheme(
                      inactiveFillColor: bgColor,
                      activeColor: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                      selectedFillColor: bgColor,
                      selectedColor: bgColor,
                      shape: PinCodeFieldShape.box,
                    ),
                    length: 6,
                    onChanged: (value) {},
                  ),
                ),
                Container(height: 20),
                Container(
                    width: Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.width
                        : 300,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: StadiumBorder(),
                            padding: const EdgeInsets.all(10)),
                        child: Text("Confirm",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                color: black, fontWeight: FontWeight.bold))))
              ]))
        ],
      ),
    );
  }
}
