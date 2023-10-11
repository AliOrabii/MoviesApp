import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

getToast(
    {required String message, required bool isDark, bool isError = false}) {
  Fluttertoast.showToast(
    toastLength: Toast.LENGTH_SHORT,
    msg: message,
    backgroundColor: isError
        ? Colors.red
        : isDark
            ? Colors.white
            : Colors.amberAccent,
    timeInSecForIosWeb: 1,
    gravity: ToastGravity.BOTTOM,
    fontSize: 16,
    textColor: !isDark ? Colors.white : Colors.amberAccent,
  );
}
