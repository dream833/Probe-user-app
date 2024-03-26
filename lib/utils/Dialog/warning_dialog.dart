import 'package:flutter/material.dart';

class CustomDialog {
  static void warningDialog(BuildContext context, String title) {
    showDialog(context: context, builder: (_){
      return AlertDialog(
        title: Text(title),
      );
    });
  }
}