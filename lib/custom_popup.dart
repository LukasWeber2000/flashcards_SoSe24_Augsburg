import 'package:flutter/material.dart';

class CustomPopup {
  final String title;
  CustomPopup({required this.title});

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),

          );
        });
  }
}
