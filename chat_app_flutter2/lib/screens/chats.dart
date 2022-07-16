import 'package:chat_app_flutter2/main.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChatAndStores(size, dark_blue);
  }
}

SingleChildScrollView ChatAndStores(Size size, Color darker_blue) {
  return SingleChildScrollView(
    child: Wrap(
      children: [
        Title('Stores'),
        Stores(size),
        Title('Chats'),
        Chats(size),
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

Container Chats(Size size) {
  return Container(
    margin: const EdgeInsets.only(
      top: 20,
    ),
    height: 600,
    child: ListView.builder(
      itemCount: chats.length,
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
            title: Text(chats[index]["userName"]),
            subtitle: Text(
              chats[index]["massage"],
              style: TextStyle(
                color: chats[index]["unread"] == null
                    ? Color.fromRGBO(255, 255, 255, 0.5)
                    : green,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chats[index]["time"].toString(),
                  style: TextStyle(
                    color: chats[index]["unread"] == null
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
                  child: chats[index]["unread"] == null
                      ? Container()
                      : CircleAvatar(
                          backgroundColor: green,
                          child: Text(
                            chats[index]["unread"].toString(),
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
                      chats[index]["img"],
                    ),
                  )),
            ),
          ),
        );
      },
    ),
  );
}
