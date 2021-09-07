import 'package:flutter/material.dart';

class Utils {
  static bool isValidEmail(String emailId) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(emailId)) ? false : true;
  }

  static void showSnackBar({@required BuildContext? context, @required String? message, @required bool? isError}) {
    final snackBar = SnackBar(
      content: Text(
        message!,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: isError! ? Colors.red : Colors.green,
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}
