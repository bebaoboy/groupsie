
import 'package:groupsie/shared/strings.dart';

class RegisterInfo {
  String email = "", password = "", password2 = "", username = "";

  onEmailChange(value) {
    email = value;
    // log(value);
  }

  onPasswordChange(value) {
    password = value;
  }

  onPasswordChange2(value) {
    password2 = value;
  }

  onUsernameChange(value) {
    username = value;
  }

  emailValidate() {
    // log("validated");
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)
        ? null
        : Strings.emailError;
  }

  usernameValidate() {
    if (username.isNotEmpty && username.length < 6) {
      return Strings.usernameEmptyError;
    }
    if (!username.contains(RegExp(r"^[a-zA-Z0-9._-]+$"))) {
      return Strings.usernameSpecialCharactersError;
    }
  }

  passwordValidate() {
    if (password.length < 6) {
      return Strings.passwordTooShort;
    }
  }

  passwordConfirmValidate() {
    return password2.compareTo(password) == 0
        ? null
        : Strings.passwordConfirmError;
  }
}
