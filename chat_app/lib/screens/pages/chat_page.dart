import 'package:chat_app/data/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widget/chat/chat_bubbles.dart';
import '../../widget/chat/header.dart';
import '../../widget/chat/new_messages.dart';

class ChatPage extends StatefulWidget {
  final friendName;
  final friendUid;
  final frindProfile;
  ChatPage(
      {required this.friendName,
      required this.friendUid,
      required this.frindProfile});

  @override
  State<ChatPage> createState() =>
      _ChatPageState(friendName, friendUid, frindProfile);
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference<Map<String, dynamic>> chats =
      FirebaseFirestore.instance.collection('chats');
  final friendName;
  final friendUid;
  final frindProfile;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  var chatDocId;
  _ChatPageState(this.friendName, this.friendUid, this.frindProfile);

  @override
  void initState() {
    super.initState();
    chats
        .where('users', isEqualTo: {currentUser: null, friendUid: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'users': {currentUser: null, friendUid: null},
              'names': {
                currentUser: FirebaseAuth.instance.currentUser?.displayName,
                friendUid: friendName
              },
            }).then((value) => chatDocId = value);
          }
        })
        .onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    image: AssetImage('assets/img/wla.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                header(context, friendName, frindProfile.toString()),
                chatBubble(chatDocId, friendUid),
                newMsg(context, chats, chatDocId, currentUser, friendName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
