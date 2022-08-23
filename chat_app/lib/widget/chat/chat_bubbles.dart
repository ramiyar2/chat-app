import 'package:chat_app/widget/chat/chat-bubbles/audio.dart';
import 'package:chat_app/widget/chat/chat-bubbles/image.dart';
import 'package:chat_app/widget/chat/chat-bubbles/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/color.dart';
import 'chat-bubbles/style.dart';

class ChatBubble extends StatelessWidget {
  final chatDocId;
  final friendUid;
  var data;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  ChatBubble({Key? key, this.chatDocId, this.friendUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: const Text('field to load date from server'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading ...');
        }
        if (snapshot.hasData) {
          final docs = snapshot.data?.docs;
          List<Widget> docsList =
              docs.map<Widget>((DocumentSnapshot documentSnapshot) {
            data = documentSnapshot.data();
            return Row(
              mainAxisAlignment: getAligment(data['uid'],
                  isRow: true, currentUser: currentUser),
              children: [
                Container(
                    margin: getMargin(data['uid'], currentUser),
                    padding: data['isImage']
                        ? const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10)
                        : const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: getColor(data['uid'],
                          isBg: true, currentUser: currentUser),
                      borderRadius: getBorderRadios(data['uid'], currentUser),
                      border: Border.all(
                          color: getColor(data['uid'],
                              isBorder: true, currentUser: currentUser),
                          width: 1),
                    ),
                    child: data['isImage']
                        ? ImageMsg(
                            data: data,
                            currentUser: currentUser,
                          )
                        : data['isAudio']
                            ? AudioMsg(data: data)
                            : data['isFile']
                                ? Container(
                                    child: Column(
                                      crossAxisAlignment: getAligment(
                                          data['uid'],
                                          isColumn: true,
                                          currentUser: currentUser),
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: white_op,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Icon(Icons
                                                  .document_scanner_rounded),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(data['file']),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '10:10 PM',
                                          style: TextStyle(
                                              color: white_op, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  )
                                : TextMsg(
                                    data: data, currentUser: currentUser)),
              ],
            );
          }).toList();
          return Expanded(
            child: ListView(
              reverse: true,
              children: docsList,
            ),
          );
        }
        return Container();
      },
    );
  }
}
