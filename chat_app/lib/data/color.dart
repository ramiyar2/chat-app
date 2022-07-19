import 'package:flutter/material.dart';

Color green = const Color.fromRGBO(30, 253, 119, 1);
Color dark_green = const Color.fromRGBO(0, 154, 62, 1);
Color dark_blue = const Color.fromRGBO(24, 42, 43, 1);
Color darker_blue = const Color.fromRGBO(1, 26, 27, 1);

MaterialColor customColorGreen =
    MaterialColor(Color.fromRGBO(30, 253, 119, 1).value, <int, Color>{
  50: Color.fromRGBO(30, 253, 119, 0.1),
  100: Color.fromRGBO(30, 253, 119, 0.2),
  200: Color.fromRGBO(30, 253, 119, 0.3),
  300: Color.fromRGBO(30, 253, 119, 0.4),
  400: Color.fromRGBO(30, 253, 119, 0.5),
  500: Color.fromRGBO(30, 253, 119, 0.6),
  600: Color.fromRGBO(30, 253, 119, 0.7),
  700: Color.fromRGBO(30, 253, 119, 0.8),
  800: Color.fromRGBO(30, 253, 119, 0.9),
  900: Color.fromRGBO(30, 253, 119, 1),
});
