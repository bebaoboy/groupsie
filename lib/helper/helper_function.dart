import 'package:flutter/material.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  // keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  // saving the data

  // getting the data
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static void nextScreen(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void nextScreenReplacement(context, page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void lastScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void showSnackBar(context, Color color, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontSize: Constants.errorFontSize)),
      backgroundColor: color,
      duration: const Duration(seconds: 6),
      action: SnackBarAction(label: Strings.ok, onPressed: (){}, textColor: Colors.white,),
    ));
  }
}
