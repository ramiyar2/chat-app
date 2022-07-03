import 'package:chat_app_flutter2/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'pages/home.dart';
import 'pages/verify.dart';

void main() => runApp(const MyApp());
var green = const Color.fromRGBO(30, 253, 119, 1);
var dark_green = const Color.fromRGBO(0, 154, 62, 1);
var dark_blue = const Color.fromRGBO(24, 42, 43, 1);
var darker_blue = const Color.fromRGBO(1, 26, 27, 1);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Montserrat',
          hintColor: dark_green,
          primarySwatch: customColorGreen,
          scaffoldBackgroundColor: darker_blue,
          highlightColor: dark_blue,
          splashColor: dark_green),
      initialRoute: '/',
      routes: {
        '/': (context) => const _SplahPage(),
      },
    );
  }
}

class _SplahPage extends StatelessWidget {
  const _SplahPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class _SigninPage extends StatelessWidget {
  const _SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Signin(green, dark_green, dark_blue, darker_blue);
    return HomePage();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/img/myLogo.png'),
      logoSize: 65,
      title: Text(
        "Chats",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 42,
          color: green,
        ),
      ),
      backgroundColor: darker_blue,
      showLoader: true,
      loaderColor: green,
      loadingText: Text(
        "Loading ...",
        style: TextStyle(
          color: green,
        ),
      ),
      navigator: const _SigninPage(),
      durationInSeconds: 3,
    );
  }
}

MaterialColor customColorGreen = MaterialColor(
  Color.fromRGBO(30, 253, 119, 1).value,
  <int, Color>{
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
  },
);
