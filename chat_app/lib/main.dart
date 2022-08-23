import 'package:chat_app/data/routes.dart';
import 'package:chat_app/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'data/color.dart';
import 'data/theme.dart';

//import 'pages/home.dart';
import 'screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var number;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences _pref = await SharedPreferences.getInstance();
  number = _pref.getString('number');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/',
      routes: routes,
    );
  }
}

class SplahPage extends StatelessWidget {
  const SplahPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class _SigninPage extends StatelessWidget {
  const _SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return number == null ? Signin() : HomePage();
    // return Signin();
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
