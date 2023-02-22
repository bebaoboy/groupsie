import 'package:flutter/material.dart';
import 'package:groupsie/shared/constants.dart';

var standardButtonRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(4.0),
);

// size
const double boxSize = 10;
const double divThickness = 2;

// padding
const double hPadding = 20, vPadding = 80, hPaddingWeb = 150;
const double vPaddingGroupList = 50;
const double hPaddingTile = 20, vPaddingTile = 2;

// container
const double drawerWidth = 200;

// title
const double titleSize = 40;
const titleStyle = TextStyle(
  fontSize: titleSize,
  fontWeight: FontWeight.bold,
  color: Constants.mainColor,
);
const titleFadedStyle = TextStyle(
  fontSize: titleSize,
  fontWeight: FontWeight.bold,
  color: Constants.fadedColor,
);
const headerStyle = TextStyle(
  fontSize: titleSize * 0.5,
  fontWeight: FontWeight.bold,
  color: Constants.mainColor,
);

//
// app bar
const appBarStyle = TextStyle(
  fontSize: titleSize * 0.75,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const tileTextStyle = TextStyle(fontSize: titleSize * 0.60);
const standardTextStyle = TextStyle(fontSize: titleSize * 0.50);
const accountNameStyle =
    TextStyle(fontSize: titleSize * 0.55, fontWeight: FontWeight.bold);

//
// prompt
const promptStyle =
    TextStyle(fontSize: titleSize * 0.45, fontWeight: FontWeight.w400);

//
// input
const double inputTextSize = Constants.standardFontSize;
const textInputDecoration = InputDecoration(
  errorStyle: TextStyle(fontWeight: FontWeight.bold),
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Constants.mainColor, width: 3),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Constants.mainColor, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Constants.errorColor, width: 3),
  ),
);

//
// login button
const loginButtonTextStyle =
    TextStyle(fontSize: inputTextSize * 0.8, fontWeight: FontWeight.w500);

// final loginButtonStyle = ElevatedButton.styleFrom(
//   elevation: 0,
//   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.5))
// );

//
// register
const registerPromptStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: titleSize * 0.35,
);

const registerActionStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: titleSize * 0.35,
  decoration: TextDecoration.underline,
);

//
// icons
const emailIcon = Icon(Icons.email_rounded, color: Constants.mainColor);
const passwordIcon = Icon(Icons.lock_clock_rounded, color: Constants.mainColor);
const usernameIcon = Icon(Icons.contacts, color: Constants.mainColor);
const searchIcon = Icon(Icons.search_outlined, color: Colors.white);
const accountIcon = Icon(
  Icons.account_circle,
  color: Constants.mainColor,
  size: 100,
);
const accountIconLg = Icon(
  Icons.account_circle,
  color: Constants.mainColor,
  size: 200,
);
const cancelIcon = Icon(
  Icons.cancel_outlined,
  color: Constants.errorColor,
);
const continueIcon = Icon(
  Icons.check_circle_outline,
  color: Constants.doneColor,
);
const addIcon = Icon(
  Icons.add_outlined,
  color: Colors.white,
);

// app bar icon
const groupIcon = Icon(Icons.group_outlined);
const logoutIcon = Icon(Icons.logout_outlined);
const profileIcon = Icon(Icons.account_box_outlined);
