import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/color.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:date_format/date_format.dart';

class ChatBubble extends StatefulWidget {
  final chatDocId;
  final friendUid;
  ChatBubble({Key? key, this.chatDocId, this.friendUid}) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final audioPlayer = AudioPlayer();
  bool isPlayed = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  var data;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    //listen to audio state
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlayed = (state = PlayerState.playing) as bool;
      });
    });
    //listen to audio duration
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
      print(_duration.toString() + 'play /*/*+*/');
    });
    //listen to audio position
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatDocId)
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
                      ? const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
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
                      ? Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius:
                                getBorderRadios(data['uid'], currentUser),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data['msg']),
                            ),
                          ),
                          child: null,
                        )
                      : data['isAudio']
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      if (isPlayed) {
                                        await audioPlayer.pause();
                                      } else {
                                        print(_duration.toString() +
                                            'play /*/*+*/');
                                        await audioPlayer.play(UrlSource(
                                            'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3?_=1'));
                                      }
                                    },
                                    icon: Icon(isPlayed
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded)),
                                Expanded(
                                    child: Slider(
                                  onChanged: (double value) async {
                                    final position =
                                        Duration(seconds: value.toInt());
                                    await audioPlayer.seek(position);
                                    await audioPlayer.resume();
                                  },
                                  min: 0,
                                  max: _duration.inSeconds.toDouble(),
                                  value: _position.inSeconds.toDouble(),
                                )),
                                Container(
                                  child: Text(_duration.toString()),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                                  getAligment(data['uid'], isColumn: true),
                              children: [
                                Text(
                                  data['msg'],
                                  style: TextStyle(
                                      color:
                                          getColor(data['uid'], isText: true),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
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
        }
        return Container();
      },
    );
  }
}

// StreamBuilder<QuerySnapshot<Map<String, dynamic>>> chatBubble(
//     chatDocId, friendUid) {
//   return StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatDocId)
//         .collection('messages')
//         .orderBy('createdOn', descending: true)
//         .snapshots(),
//     builder: (BuildContext context, AsyncSnapshot snapshot) {
//       if (snapshot.hasError) {
//         return const Center(
//           child: const Text('field to load date from server'),
//         );
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Text('loading ...');
//       }
//       if (snapshot.hasData) {
//         final docs = snapshot.data?.docs;
//         List<Widget> docsList =
//             docs.map<Widget>((DocumentSnapshot documentSnapshot) {
//           data = documentSnapshot.data();
//           return Row(
//     mainAxisAlignment: getAligment(data['uid'], isRow: true),
//     children: [
//       Container(
//         margin: getMargin(data['uid']),
//         padding: data['isImage']
//             ? const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
//             : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.7,
//         ),
//         decoration: BoxDecoration(
//           color: getColor(data['uid'], isBg: true),
//           borderRadius: getBorderRadios(data['uid']),
//           border: Border.all(
//               color: getColor(data['uid'], isBorder: true), width: 1),
//         ),
//         child: data['isImage']
//             ? Container(
//                 width: double.infinity,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: getBorderRadios(data['uid']),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(data['msg']),
//                   ),
//                 ),
//                 child: null,
//               )
//             : data['isAudio']
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.play_arrow_rounded)),
//                       Expanded(child: Slider(
//                         onChanged: (double value) {  },
//                         value: _position,

//                       )),
//                       Container(
//                         child: Text('14:51'),
//                       ),
//                     ],
//                   )
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment:
//                         getAligment(data['uid'], isColumn: true),
//                     children: [
//                       Text(
//                         data['msg'],
//                         style: TextStyle(
//                             color: getColor(data['uid'], isText: true),
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         '10:10 PM',
//                         style: TextStyle(color: white_op, fontSize: 10),
//                       ),
//                     ],
//                   ),
//       ),
//     ],
//   );
//         }).toList();
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             children: docsList,
//           ),
//         );
//       }
//       return Container();
//     },
//   );

// }

// Row Bubble(BuildContext context) {
//   return Row(
//     mainAxisAlignment: getAligment(data['uid'], isRow: true),
//     children: [
//       Container(
//         margin: getMargin(data['uid']),
//         padding: data['isImage']
//             ? const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
//             : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.7,
//         ),
//         decoration: BoxDecoration(
//           color: getColor(data['uid'], isBg: true),
//           borderRadius: getBorderRadios(data['uid']),
//           border: Border.all(
//               color: getColor(data['uid'], isBorder: true), width: 1),
//         ),
//         child: data['isImage']
//             ? Container(
//                 width: double.infinity,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: getBorderRadios(data['uid']),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(data['msg']),
//                   ),
//                 ),
//                 child: null,
//               )
//             : data['isAudio']
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.play_arrow_rounded)),
//                       Expanded(child: Slider(
//                         onChanged: (double value) {  },
//                         value: _position,

//                       )),
//                       Container(
//                         child: Text('14:51'),
//                       ),
//                     ],
//                   )
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment:
//                         getAligment(data['uid'], isColumn: true),
//                     children: [
//                       Text(
//                         data['msg'],
//                         style: TextStyle(
//                             color: getColor(data['uid'], isText: true),
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         '10:10 PM',
//                         style: TextStyle(color: white_op, fontSize: 10),
//                       ),
//                     ],
//                   ),
//       ),
//     ],
//   );

// }

getAligment(uid, {bool? isRow, bool? isColumn, currentUser}) {
  if (isRow == true) {
    if (uid == currentUser) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.start;
    }
  }
  if (isColumn == true) {
    if (uid == currentUser) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }
}

getBorderRadios(uid, currentUser) {
  if (uid == currentUser) {
    return const BorderRadius.only(
      topLeft: Radius.circular(14),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(14),
      bottomRight: Radius.circular(14),
    );
  } else {
    return const BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(14),
      bottomLeft: const Radius.circular(14),
      bottomRight: const Radius.circular(14),
    );
  }
}

getColor(uid, {bool? isBorder, bool? isBg, bool? isText, currentUser}) {
  if (isBorder == true) {
    if (uid == currentUser) {
      return dark_green;
    } else {
      return dark_blue;
    }
  }
  if (isBg == true) {
    if (uid == currentUser) {
      return dark_blue;
    } else {
      return dark_green;
    }
  }
  if (isText == true) {
    if (uid == currentUser) {
      return green_op;
    } else {
      return dark_blue;
    }
  }
}

getMargin(uid, currentUser) {
  if (uid == currentUser) {
    return const EdgeInsets.only(
      top: 10,
      right: 10,
      left: 0,
    );
  } else {
    return const EdgeInsets.only(
      top: 10,
      right: 0,
      left: 10,
    );
  }
}
