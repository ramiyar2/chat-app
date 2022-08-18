import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'chat_state.g.dart';

// This is the class used by rest of your codebase
class ChatState = _ChatState with _$ChatState;

// The store-class
abstract class _ChatState with Store {
  var currentUser = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference<Map<String, dynamic>> chats =
      FirebaseFirestore.instance.collection('chats');

  @observable
  Map<String, dynamic> message = ObservableMap();

  void getMassagese(friendUid, chatId, profileImageUrl) {
    chats.doc(chatId).collection('messages').snapshots().forEach((doc) {
      FirebaseFirestore.instance
          .collection('chats/$chatId/messages')
          .limit(1)
          .orderBy('createdOn', descending: true)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          message[chatId] = {
            'msg': snapshot.docs.first['msg'],
            'time': snapshot.docs.first['createdOn'],
            'frindName': snapshot.docs.first['frindName'],
            'frindUid': snapshot.docs.first['uid'],
            'friendProfileImageUrl': profileImageUrl,
          };
        }
      });
    });
  }

  // get profile image and massages
  void getFullInfo(friendUid, chatId) {
    var profileImageUrl;
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: friendUid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        profileImageUrl = snapshot.docs.first['profileImageUrl'];
        getMassagese(friendUid, chatId, profileImageUrl);
      }
    });
  }

  @action
  void RefrenceChatForCurrentUser() {
    var chatId;
    var friendUid;
    chats
        .where('users.$currentUser', isNull: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      snapshot.docs.map((DocumentSnapshot documentSnapshot) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        chatId = data['chatId'];
        friendUid = data['friendUid'];
        getFullInfo(friendUid, chatId);
        return data['chatId'];
      }).toList();
    });
  }
}
