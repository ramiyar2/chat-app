import 'package:chat_app_flutter2/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

void main() => runApp(MyApp());

var green = Color.fromRGBO(30, 253, 119, 1);
var dark_green = Color.fromRGBO(0, 154, 62, 1);
var dark_blue = Color.fromRGBO(24, 42, 43, 1);
var darker_blue = Color.fromRGBO(1, 26, 27, 1);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Raleway'),
      initialRoute: '/',
      routes: {
        '/': (context) => _SplahPage(),
      },
    );
  }
}

class _SplahPage extends StatelessWidget {
  const _SplahPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return splashScreen();
  }
}

class _SigninPage extends StatelessWidget {
  const _SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return signin(green, dark_green, dark_blue, darker_blue);
  }
}

class splashScreen extends StatelessWidget {
  const splashScreen({
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
      navigator: _SigninPage(),
      durationInSeconds: 3,
    );
  }
}
