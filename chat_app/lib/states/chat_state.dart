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

  @action
  void RefrenceChatForCurrentUser() {
    var chatDocs = [];
    chats
        .where('users.$currentUser', isNull: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      chatDocs = snapshot.docs.map((DocumentSnapshot documentSnapshot) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> names = data['names'];
        names.remove(currentUser);
        return {'docId': documentSnapshot.id, 'name': names.values.first};
      }).toList();
      chatDocs.forEach((doc) {
        FirebaseFirestore.instance
            .collection('chats/${doc['docId']}/messages')
            .orderBy('createdOn', descending: true)
            .limit(1)
            .snapshots()
            .listen((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            message[doc['name']] = {
              'msg': snapshot.docs.first['msg'],
              'time': snapshot.docs.first['createdOn'],
              'frindName': doc['name'],
              'frindUid': snapshot.docs.first['uid'],
            };
          }
        });
      });
    });
  }
}
