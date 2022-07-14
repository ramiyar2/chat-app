import 'dart:ui';

import 'package:chat_app_flutter2/main.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _dogHouse =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/dog-house.png";
    String _call =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/phone-disconnected.png";
    String _user =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/user.png";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme(),
      home: Scaffold(
        bottomNavigationBar: NavigationBar(_dogHouse, _call, _user),
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
              items.isNotEmpty ? ChatAndStores(size) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Container NavigationBar(String _dogHouse, String _call, String _user) {
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
          currentIndex: 0,
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

  Expanded ChatAndStores(Size size) {
    return Expanded(
      child: Container(
        height: 537,
        decoration: BoxDecoration(
            color: darker_blue,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0))),
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Title('Stores'),
              Stores(size),
              Title('Chats'),
              Chats(size),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView Stores(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            width: size.width,
            height: 60,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(store[index]['img']),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(color: green, width: 2),
                      ),
                    ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      width: 20,
                    ),
                itemCount: store.length),
          ),
        ],
      ),
    );
  }

  Container Title(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 25),
      child: Text(
        title,
        style: TextStyle(color: green, fontSize: 20),
      ),
    );
  }

  Container Chats(Size size) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      height: 600,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: dark_blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: green,
                width: 2.0,
              ),
            ),
            child: ListTile(
              title: Text(items[index]["userName"]),
              subtitle: Text(
                items[index]["massage"],
                style: TextStyle(
                  color: items[index]["unread"] == null
                      ? Color.fromRGBO(255, 255, 255, 0.5)
                      : green,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    items[index]["time"].toString(),
                    style: TextStyle(
                      color: items[index]["unread"] == null
                          ? Color.fromRGBO(255, 255, 255, 0.5)
                          : green,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    child: items[index]["unread"] == null
                        ? Container()
                        : CircleAvatar(
                            backgroundColor: green,
                            child: Text(
                              items[index]["unread"].toString(),
                              style: TextStyle(color: darker_blue),
                            ),
                          ),
                  ),
                ],
              ),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        items[index]["img"],
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
