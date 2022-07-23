import 'package:chat_app/data/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/color.dart';
import 'package:flutter/material.dart';
import '../../data/icons.dart';

class ChatPage extends StatefulWidget {
  final friendName;
  final friendUid;
  ChatPage({required this.friendName, required this.friendUid});

  @override
  State<ChatPage> createState() => _ChatPageState(friendName, friendUid);
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference<Map<String, dynamic>> chats =
      FirebaseFirestore.instance.collection('chats');
  final friendName;
  final friendUid;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  var chatDocId;
  var data;
  late bool isMe;
  TextEditingController massController = TextEditingController();
  _ChatPageState(this.friendName, this.friendUid);

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
            }).then((value) => chatDocId = value);
          }
        })
        .onError((error, stackTrace) => null);
  }

  void sendMsg(String msg) {
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

  void userSend(uid) {
    uid == currentUser ? isMe = true : isMe == false;
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
                header(video, call),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(chatDocId)
                      .collection('messages')
                      .orderBy('createdOn', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('field to load date from server'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    final docs = snapshot.data?.docs;
                    List<Widget> docsList =
                        docs.map<Widget>((DocumentSnapshot documentSnapshot) {
                      data = documentSnapshot.data();
                      userSend(data['uid']);
                      return Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              right: isMe ? 10 : 0,
                              left: isMe ? 0 : 10,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            decoration: BoxDecoration(
                              color: isMe ? dark_blue : dark_green,
                              borderRadius: BorderRadius.only(
                                topLeft: isMe
                                    ? Radius.circular(14)
                                    : Radius.circular(0),
                                topRight: isMe
                                    ? Radius.circular(0)
                                    : Radius.circular(14),
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              ),
                              border: Border.all(
                                  color: isMe ? dark_green : dark_blue,
                                  width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['msg'],
                                  style: TextStyle(
                                      color: isMe ? green_op : darker_blue,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '10:10 PM',
                                  style:
                                      TextStyle(color: white_op, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList();
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: docsList,
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: dark_blue_op,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.emoji_emotions)),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Text('send a message ...'),
                          ),
                          controller: massController,
                          onSubmitted: (val) => sendMsg(val),
                        ),
                      ),
                      IconButton(
                          onPressed: () => sendMsg(massController.text),
                          icon: Icon(Icons.send)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container header(String _video, String _call) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: darker_blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [BoxShadow(color: green, spreadRadius: 1)]),
      child: ListTile(
        title: Text(friendName.toString()),
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
                        "http://placeimg.com/640/480/any",
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
    );
  }
}
