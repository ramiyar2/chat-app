import 'dart:collection';

import 'package:chat_app/states/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/color.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../server/callChatScreen.dart';
import 'pages/chat_page.dart';

class Chat extends StatefulWidget {
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChatAndStores(size, context);
  }
}

SingleChildScrollView ChatAndStores(Size size, BuildContext context) {
  return SingleChildScrollView(
    child: Wrap(
      children: [
        Title('Stores'),
        Stores(size),
        Title('Chats'),
        Chats(size, context),
      ],
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

Container Chats(Size size, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(
      top: 10,
    ),
    height: 600,
    child: ListView(
      children: chatState.message.values.toList().map<Widget>((data) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: dark_blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: data['frindName'] == null
                  ? Color.fromARGB(0, 0, 0, 0)
                  : green,
              width: 2.0,
            ),
          ),
          child: ListTile(
            onTap: () => callChatScreen(context, data['frindName'],
                data['frindUid'], data["friendProfileImageUrl"]),
            title: Text(data['frindName']),
            subtitle: Text(
              data['msg'],
              style: TextStyle(
                color: data['msg'] == null
                    ? Color.fromRGBO(255, 255, 255, 0.5)
                    : green,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (data['time'].toDate().year == DateTime.now().year &&
                          data['time'].toDate().month == DateTime.now().month &&
                          data['time'].toDate().day == DateTime.now().day &&
                          data['time'].toDate().hour == DateTime.now().hour &&
                          data['time'].toDate().minute == DateTime.now().minute)
                      ? "now"
                      : data['time'].toDate().hour.toString() +
                          ' : ' +
                          data['time'].toDate().minute.toString(),
                  style: TextStyle(
                    color: data['time'] == null
                        ? Color.fromRGBO(255, 255, 255, 0.5)
                        : green,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   width: 25,
                //   height: 25,
                //   child:
                //       // chats[index]["unread"] == null
                //       //     ? Container()
                //       //     :
                //       CircleAvatar(
                //     backgroundColor: green,
                //     child: Text(
                //       "1",
                //       style: TextStyle(color: darker_blue),
                //     ),
                //   ),
                // ),
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
                      data["friendProfileImageUrl"],
                    ),
                  )),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
