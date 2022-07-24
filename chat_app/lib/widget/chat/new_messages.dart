import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/color.dart';

TextEditingController massController = TextEditingController();

void sendMsg(String msg, chats, chatDocId, currentUser) {
  if (msg == '' || msg == null) {
    return;
  } else {
    massController.clear();
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'msg': msg
    });
  }
}

Container newMsg(BuildContext context, chats, chatDocId, currentUser) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
        color: dark_blue_op, borderRadius: BorderRadius.circular(20)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions)),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text('send a message ...'),
            ),
            controller: massController,
            onSubmitted: (val) => sendMsg(val, chats, chatDocId, currentUser),
          ),
        ),
        IconButton(
            onPressed: () =>
                sendMsg(massController.text, chats, chatDocId, currentUser),
            icon: Icon(Icons.send)),
      ],
    ),
  );
}
