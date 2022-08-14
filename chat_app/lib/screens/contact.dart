import 'package:chat_app/screens/other/audio_call.dart';
import 'package:chat_app/screens/other/video_call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../data/color.dart';
import '../server/callChatScreen.dart';
import '../server/chatUid.dart';
import '../states/lib.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _video =
        "https://img.icons8.com/fluency-systems-regular/48/000000/video-call.png";
    String _call =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/phone-disconnected.png";
    return Wrap(
      children: [Title('Contact'), ContactsList(_video, _call)],
    );
  }

  Container ContactsList(String _video, String _call) {
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    final currentUserName = FirebaseAuth.instance.currentUser?.displayName;
    late String chatId;
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 600,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isNotEqualTo: currentUser)
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
            if (snapshot.hasData) {
              final docs = snapshot.data?.docs;
              return ListView(
                children: usersState.users.values.toList().map<Widget>((data) {
                  if (data['uid'] != currentUser) {
                    return ListTile(
                      title: Text(data['userName']),
                      subtitle: Text(
                        data['status'],
                        style: TextStyle(color: green_op),
                      ),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                data["profileImageUrl"],
                              ),
                            )),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                chatId = createChatId(
                                    currentUserName, data['userName']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoCallScreen(chatId)));
                              },
                              icon: Image.network(
                                _video,
                                width: 28,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                chatId = createChatId(
                                    currentUserName, data['userName']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AudioCallScreen(chatId)));
                              },
                              icon: Image.network(
                                _call,
                                width: 28,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => callChatScreen(context, data['userName'],
                          data['uid'], data['profileImageUrl']),
                    );
                  } else
                    return Container();
                }).toList(),
              );
              // return ListView.separated(
              //     itemBuilder: (BuildContext context, int index) => ListTile(
              //           title: Text(docs[index]['userName']),
              //           subtitle: Text(
              //             docs[index]['status'],
              //             style: TextStyle(color: green_op),
              //           ),
              //           leading: Container(
              //             width: 60,
              //             height: 60,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(60),
              //                 image: DecorationImage(
              //                   fit: BoxFit.cover,
              //                   image: NetworkImage(
              //                     docs[index]["profileImageUrl"],
              //                   ),
              //                 )),
              //           ),
              //           trailing: SizedBox(
              //             width: 100,
              //             child: Row(
              //               children: [
              //                 IconButton(
              //                   onPressed: () {},
              //                   icon: Image.network(
              //                     _video,
              //                     width: 28,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 IconButton(
              //                   onPressed: () {},
              //                   icon: Image.network(
              //                     _call,
              //                     width: 28,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           onTap: () => callChatScreen(context,
              //               docs[index]['userName'], docs[index]['uid']),
              //         ),
              //     separatorBuilder: (BuildContext context, int index) =>
              //         SizedBox(
              //           height: 20,
              //         ),
              //     itemCount: docs.length);

            }
            return Container();
          }),
    );
  }
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
