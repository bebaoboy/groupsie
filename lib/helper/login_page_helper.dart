import 'dart:developer';

import 'package:groupsie/shared/strings.dart';

class LoginInfo {
  String email = "", password = "";

  onEmailChange(value) {
    email = value;
    // log(value);
  }

  onPasswordChange(value) {
    password = value;
  }

  emailValidate() {
    // log("validated");
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)
        ? null
        : Strings.emailError;
  }
}
