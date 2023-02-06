import 'dart:developer';

import 'package:groupsie/shared/strings.dart';

class LoginInfo {
  bool isLoggedIn = false;
  String email = "", password = "", username = "";

  onEmailChange(value) {
    email = value;
    // log(value);
  }

  onPasswordChange(value) {
    password = value;
  }

  passwordValidate() {
    return password.isEmpty ? Strings.passwordMissing : null;
  }

  emailValidate() {
    // log("validated");
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)
        ? null
        : Strings.emailError;
  }
}
