import 'dart:ui';

import 'package:chat_app_flutter2/main.dart';
import 'package:chat_app_flutter2/screens/chat.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';

import '../screens/call.dart';
import '../screens/contact.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _dogHouse =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/dog-house.png";
    String _call =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/phone-disconnected.png";
    String _user =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/user.png";

    PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    int bottomSelectedIndex = 0;

    @override
    void initState() {
      super.initState();
    }

    void pageChanged(int index) {
      setState(() {
        bottomSelectedIndex = index;
      });
    }

    void bottomTapped(int index) {
      setState(() {
        bottomSelectedIndex = index;
        pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme(),
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
            _dogHouse, _call, _user, bottomSelectedIndex, bottomTapped),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: size.width > 600
                    ? const EdgeInsets.all(25.0)
                    : const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: HeaderImg(),
                  trailing: HeaderIcon(),
                ),
              ),
              items.isNotEmpty
                  ? Expanded(
                      child: Container(
                          height: 537,
                          decoration: BoxDecoration(
                              color: darker_blue,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0))),
                          child:
                              BluidPageView(pageController, pageChanged, size)))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  PageView BluidPageView(
      PageController pageController, void pageChanged(int index), Size size) {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[Chat(), Call(), Contact()],
    );
  }

  Container NavigationBar(String _dogHouse, String _call, String _user,
      int select, Function bottomTapped) {
    return Container(
      color: darker_blue,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 0,
          items: [
            SelectedItem(_dogHouse),
            UnSelectedItem(_call, 'Call'),
            UnSelectedItem(_user, 'Contact'),
          ],
          currentIndex: select,
          onTap: (index) {
            bottomTapped(index);
          },
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  BottomNavigationBarItem UnSelectedItem(String _call, String label) {
    return BottomNavigationBarItem(
        icon: Image.network(
          _call,
          width: 28,
          color: Color.fromRGBO(255, 255, 255, 0.5),
        ),
        label: label);
  }

  BottomNavigationBarItem SelectedItem(String _dogHouse) {
    return BottomNavigationBarItem(
        icon: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 253, 119, 0.5),
                    borderRadius: BorderRadius.circular(15)),
                child: null,
              ), // Widget that is blurred
            ),
            Image.network(
              _dogHouse,
              width: 28,
            ),
          ],
        ),
        label: 'Home');
  }

  ThemeData Theme() {
    return ThemeData(
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
  }

  Container HeaderImg() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              items[0]["img"],
            ),
          )),
    );
  }

  Wrap HeaderIcon() {
    return Wrap(
      children: [
        Icon(Icons.search),
        SizedBox(
          width: 10,
        ),
        Icon(Icons.more_vert_outlined),
      ],
    );
  }
}
