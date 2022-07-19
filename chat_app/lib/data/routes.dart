import 'package:flutter/material.dart';
import '../main.dart';
import '../pages/signin.dart';
import '../pages/verify.dart';

String h = 'h';
Map<String, Widget Function(BuildContext)> routes = {
  //'/': (context) => SplahPage(),
  'Sigin': (context) => Signin(),
  'Verfiy': (context) => Verify(h),
};
