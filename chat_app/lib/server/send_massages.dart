import 'package:cloud_firestore/cloud_firestore.dart';

sendMassage(String type, chats, chatDocId, currentUser, friendName, msg,
    {fileName}) {
  if (type == 'mas') {
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'frindName': friendName,
      'msg': msg,
      'isFile': false,
      'isImage': false,
      'isContact': false,
      'isAudio': false,
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
      'isAudio': false,
      'file': fileName,
      'contact': null,
    });
  } else if (type == 'Gallery' || type == 'Camera') {
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'frindName': friendName,
      'msg': msg,
      'isFile': false,
      'isImage': true,
      'isContact': false,
      'isAudio': false,
      'file': msg,
      'contact': null,
    });
  } else if (type == 'Audio') {
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'frindName': friendName,
      'msg': msg,
      'isFile': false,
      'isImage': false,
      'isContact': false,
      'isAudio': true,
      'file': msg,
      'contact': null,
    });
  } else if (type == 'Location') {
  } else if (type == 'Contact') {
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUser,
      'frindName': friendName,
      'msg': msg.toString(),
      'isFile': false,
      'isImage': false,
      'isContact': true,
      'isAudio': false,
      'file': null,
      'Contact': {
        'firstName': msg.name!.firstName,
        'middleName': msg.name!.middleName,
        'lastName': msg.name!.lastName,
        'nickName': msg.name!.nickName,
        'eamil': msg.emails.toString(),
        'phone': msg.phones.toString(),
      },
    });
  }
}
