import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/color.dart';

var data;
final currentUser = FirebaseAuth.instance.currentUser!.uid;
StreamBuilder<QuerySnapshot<Map<String, dynamic>>> chatBubble(
    chatDocId, friendUid) {
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
          return Bubble(context);
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

Row Bubble(BuildContext context) {
  return Row(
    mainAxisAlignment: getAligment(data['uid'], isRow: true),
    children: [
      Container(
        margin: getMargin(data['uid']),
        padding: data['isImage']
            ? const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
            : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: getColor(data['uid'], isBg: true),
          borderRadius: getBorderRadios(data['uid']),
          border: Border.all(
              color: getColor(data['uid'], isBorder: true), width: 1),
        ),
        child: data['isImage']
            ? Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: getBorderRadios(data['uid']),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data['msg']),
                  ),
                ),
                child: null,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: getAligment(data['uid'], isColumn: true),
                children: [
                  Text(
                    data['msg'],
                    style: TextStyle(
                        color: getColor(data['uid'], isText: true),
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '10:10 PM',
                    style: TextStyle(color: white_op, fontSize: 10),
                  ),
                ],
              ),
      ),
    ],
  );
}

getAligment(uid, {bool? isRow, bool? isColumn}) {
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

getBorderRadios(uid) {
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

getColor(uid, {bool? isBorder, bool? isBg, bool? isText}) {
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

getMargin(uid) {
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
