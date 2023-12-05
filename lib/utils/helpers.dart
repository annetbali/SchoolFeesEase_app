import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helpers {
  static bool emailValidator(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  static void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(msg: 'Student Number Copied');
  }
}
