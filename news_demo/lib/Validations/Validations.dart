import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Validator {
  static String validateEmail(String value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (value == '') {
      return 'Enter email address';
    } else if (!emailValid) {
      return 'Enter valid email address';
    }
    return null;
  }

  static double getPopUpHeight(int fields) {
    var feildsHeight = (fields * 90).toDouble();
    return 200 + feildsHeight;
  }

  static String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@^%#\$&*~(){}<>?:;.,\W_=+-]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Enter password';
    } else if (value.length < 8) {
      return 'Password should be min 8 characters.';
    } else {
      if (!regex.hasMatch(value))
        return "Password must have at least one Capital letter, number, and special character";
      else
        return null;
    }
  }
}
