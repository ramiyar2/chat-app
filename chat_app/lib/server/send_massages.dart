import 'package:cloud_firestore/cloud_firestore.dart';

sendMassage(String type, chats, chatDocId, currentUser, friendName, msg) {
  if (type == 'mas') {
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'frindName': friendName,
      'msg': msg,
      'isFile': false,
      'isImage': false,
      'isContact': false,
      'file': null,
      'contact': null,
    });
  } else if (type == 'Document') {
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'frindName': friendName,
      'msg': msg,
      'isFile': true,
      'isImage': false,
      'isContact': false,
      'file': msg,
      'contact': null,
    });
  } else if (type == 'Camera') {
  } else if (type == 'Gallery' || type == 'Camera') {
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'frindName': friendName,
      'msg': msg,
      'isFile': false,
      'isImage': true,
      'isContact': false,
      'file': msg,
      'contact': null,
    });
  } else if (type == 'Audio') {
  } else if (type == 'Location') {
  } else if (type == 'Contact') {}
}
