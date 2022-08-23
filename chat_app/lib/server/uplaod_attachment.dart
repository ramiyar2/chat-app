import 'dart:io';
import 'package:chat_app/server/send_massages.dart';
import 'package:firebase_storage/firebase_storage.dart';

void UploadFile(File path, String type, String fileName, chats, chatDocId,
    currentUser, friendName) async {
  var msgUrl;

  // Uploading file
  final msgUrlRef = await FirebaseStorage.instance
      .ref()
      .child('$currentUser/$type/$fileName');
  msgUrlRef.putFile(path).snapshotEvents.listen((taskSnapshot) {
    switch (taskSnapshot.state) {
      case TaskState.running:
        break;
      case TaskState.paused:
        break;
      case TaskState.success:
        msgUrlRef.getDownloadURL().then((value) {
          msgUrl = value;
          sendMassage(type, chats, chatDocId, currentUser, friendName, msgUrl,
              fileName: fileName);
        });
        break;
      case TaskState.canceled:
        break;
      case TaskState.error:
        break;
    }
  });
}
