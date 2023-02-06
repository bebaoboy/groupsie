import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HelperFunctions {
  // keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  static Future<bool> saveUserLoggedInInfo(
      {required bool isLoggedIn, email="", username=""}) async {
    final sf = await SharedPreferences.getInstance();
    final currentInfo = await getUserLoggedInInfo();
    Map<String, dynamic> infoJsonified;
    if (currentInfo!.email.isNotEmpty) {
      infoJsonified = {
        'isLoggedIn': isLoggedIn,
        'username': currentInfo.username.isEmpty ? username : currentInfo.username,
        'email': currentInfo.email
      };
    } else {
      infoJsonified = {
        'isLoggedIn': isLoggedIn,
        'username': username,
        'email': email
      };
    }

    log("key=${userLoggedInKey}json=${jsonEncode(infoJsonified)}");
    return sf.setString(userLoggedInKey, jsonEncode(infoJsonified));
  }

  // saving the data to shared references
  static Future<bool> _saveUserLoggedInStatus(bool isLoggedIn) async {
    final sf = await SharedPreferences.getInstance();
    return sf.setBool(userLoggedInKey, isLoggedIn);
  }

  static Future<bool> _saveUserLoggedInEmail(String email) async {
    final sf = await SharedPreferences.getInstance();
    return sf.setString(userNameKey, email);
  }

  static Future<bool> _saveUserLoggedInUsername(String username) async {
    final sf = await SharedPreferences.getInstance();
    return sf.setString(userEmailKey, username);
  }

  // getting the data
  static Future<String?> _getUserLoggedInInfo() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userLoggedInKey);
  }

  static Future<LoginInfo?> getUserLoggedInInfo() async {
    final info = LoginInfo();

    await _getUserLoggedInInfo().then((value) {
      if (value != null) {
        log("json=$value");

        Map<String, dynamic> lg = jsonDecode(value);
        info.email = lg['email'];
        info.username = lg['username'];
        info.isLoggedIn = lg['isLoggedIn'];
      }
    });

    return info;
  }

  static void nextScreen(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void nextScreenReplacement(context, page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void lastScreen(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void lastScreenReplacement(BuildContext context, page) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      nextScreenReplacement(context, page);
    }
  }

  static void showSnackBar(context, Color color, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: const TextStyle(fontSize: Constants.errorFontSize)),
      backgroundColor: color,
      duration: const Duration(seconds: 6),
      action: SnackBarAction(
        label: Strings.ok,
        onPressed: () {},
        textColor: Colors.white,
      ),
    ));
  }

  static void showSnackBarAndGoBack(context, Color color, message, {page}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: const TextStyle(fontSize: Constants.errorFontSize)),
      backgroundColor: color,
      duration: const Duration(seconds: 600),
      action: SnackBarAction(
        label: Strings.ok,
        onPressed: () {
          lastScreenReplacement(context, page);
        },
        textColor: Colors.white,
      ),
    ));
  }
}
