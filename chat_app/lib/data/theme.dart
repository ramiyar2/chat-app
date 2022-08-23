import 'package:flutter/material.dart';
import 'color.dart';

ThemeData themeData = ThemeData(
    fontFamily: 'Montserrat',
    hintColor: dark_green,
    primarySwatch: customColorGreen,
    scaffoldBackgroundColor: darker_blue,
    highlightColor: dark_blue,
    splashColor: dark_green);

ThemeData themeData1 = ThemeData(
  fontFamily: 'Montserrat',
  hintColor: dark_green,
  primarySwatch: customColorGreen,
  scaffoldBackgroundColor: green,
  highlightColor: dark_blue,
  splashColor: dark_green,
  canvasColor: dark_blue,
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
);
