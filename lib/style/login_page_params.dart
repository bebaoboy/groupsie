import 'package:flutter/material.dart';
import 'package:groupsie/shared/constants.dart';

// padding
const double hPadding = 20, vPadding = 80;

// title
const double titleSize = 40;
const double titleBoxSize = 10;
const titleStyle = TextStyle(
  fontSize: titleSize,
  fontWeight: FontWeight.bold,
  color: Constants.mainColor,
);

// prompt
const promptStyle =
    TextStyle(fontSize: titleSize * 0.45, fontWeight: FontWeight.w400);

// input
const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Constants.mainColor, width: 3),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Constants.mainColor, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Constants.errorColor, width: 3),
  ),
);

const bgColor = Constants.mainColor;
