import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Container(
          height: 120,
          child: Column(
            children: [
              Text("Validating Device Id"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LoadingBouncingGrid.square(
                  backgroundColor: Colors.white,
                ),
              )
            ],
          ),
        ));
      });
}
