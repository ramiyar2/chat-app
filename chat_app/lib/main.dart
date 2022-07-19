import 'package:chat_app/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'data/color.dart';
import 'data/theme.dart';

//import 'pages/home.dart';
import 'screens/home_screen.dart';
import 'pages/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
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
    return Signin();
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
