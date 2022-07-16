import 'dart:ui';
import 'package:chat_app_flutter2/main.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../screens/chats.dart';
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

    // List<BottomNavigationBarItem> _bottomNavigationBarItemCall = [
    //   UnSelectedItem(_dogHouse, 'Home'),
    //   SelectedItem(_call, 'Call'),
    //   UnSelectedItem(_user, 'Contact'),
    // ];
    // List<BottomNavigationBarItem> _bottomNavigationBarItemContact = [
    //   UnSelectedItem(_dogHouse, 'Home'),
    //   UnSelectedItem(_call, 'Call'),
    //   SelectedItem(_user, 'Contact'),
    // ];

    int bottomSelectedIndex = 0;

    PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    void bottomTapped(int index) {
      setState(() {
        bottomSelectedIndex = index;
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      });
    }

    List<BottomNavigationBarItem> _bottomNavigationBarItemChat = [
      UnSelectedItem(_dogHouse, 'Home'),
      SelectedItem(_call, 'Call'),
      UnSelectedItem(_user, 'Contact'),
    ];
    List<BottomNavigationBarItem> _bottomNavigationBarItem =
        _bottomNavigationBarItemChat;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme(),
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
            _bottomNavigationBarItem, bottomSelectedIndex, bottomTapped),
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
              date.isNotEmpty
                  ? Expanded(
                      child: Container(
                          height: 537,
                          decoration: BoxDecoration(
                              color: darker_blue,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0))),
                          child: BluidPageView(pageController, size)))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  PageView BluidPageView(PageController pageController, Size size) {
    return PageView(
      controller: pageController,
      children: <Widget>[
        chats.isNotEmpty ? Chat() : FiledLoadDate(),
        call.isNotEmpty ? const Call() : FiledLoadDate(),
        contact.isNotEmpty ? const Contact() : FiledLoadDate()
      ],
    );
  }

  Center FiledLoadDate() {
    return const Center(
      child: const Text(
        'field to load date from server',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container NavigationBar(
      List<BottomNavigationBarItem> _bottomNavigationBarItem,
      int bottomSelectedIndex,
      void bottomTapped(int index)) {
    return Container(
      color: darker_blue,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 0,
          items: _bottomNavigationBarItem,
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  BottomNavigationBarItem UnSelectedItem(String _img, String label) {
    return BottomNavigationBarItem(
        icon: Image.network(
          _img,
          width: 28,
          color: const Color.fromRGBO(255, 255, 255, 0.5),
        ),
        label: label);
  }

  BottomNavigationBarItem SelectedItem(String icon, String label) {
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
              icon,
              width: 28,
            ),
          ],
        ),
        label: label);
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
              chats[0]["img"],
            ),
          )),
    );
  }

  Wrap HeaderIcon() {
    return Wrap(
      children: [
        const Icon(Icons.search),
        const SizedBox(
          width: 10,
        ),
        const Icon(Icons.more_vert_outlined),
      ],
    );
  }
}
