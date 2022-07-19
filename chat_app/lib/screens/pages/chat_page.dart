import '../../data/color.dart';
import 'package:flutter/material.dart';
import '../../data/data.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _video =
        "https://img.icons8.com/fluency-systems-regular/48/000000/video-call.png";
    String _call =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/phone-disconnected.png";
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: darker_blue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: ListTile(
            title: Text(chats[0]["userName"]),
            leading: SizedBox(
              width: 110,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_backspace_rounded),
                    color: Colors.white,
                    iconSize: 28,
                  ),
                  Container(
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
                  ),
                ],
              ),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.network(
                      _video,
                      width: 28,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.network(
                      _call,
                      width: 28,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
