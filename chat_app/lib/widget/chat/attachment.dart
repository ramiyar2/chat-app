import 'dart:io';

import 'package:chat_app/server/send_massages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import '../../server/uplaod_attachment.dart';

AddAttachment(BuildContext context, chats, chatDocId, currentUser, friendName) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(bottom: 70),
          child: Container(
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AttachmentType(Icons.document_scanner, "Document", chats,
                          chatDocId, currentUser, friendName),
                      AttachmentType(Icons.camera_alt_rounded, "Camera", chats,
                          chatDocId, currentUser, friendName),
                      AttachmentType(Icons.image_rounded, "Gallery", chats,
                          chatDocId, currentUser, friendName),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AttachmentType(Icons.headphones, "Audio", chats,
                          chatDocId, currentUser, friendName),
                      AttachmentType(Icons.location_on_rounded, "Location",
                          chats, chatDocId, currentUser, friendName),
                      AttachmentType(Icons.perm_contact_calendar_rounded,
                          "Contact", chats, chatDocId, currentUser, friendName),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

InkWell AttachmentType(IconData customIcon, String type, chats, chatDocId,
    currentUser, friendName) {
  return InkWell(
    onTap: () => pickeFile(type, chats, chatDocId, currentUser, friendName),
    child: Column(
      children: [
        Ink(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: const Alignment(.05, -1),
              end: const Alignment(-.05, 1),
              stops: const [.5, .5],
              colors: <Color>[
                green_op,
                dark_green,
              ],
            ),
          ),
          child: Icon(
            customIcon,
            color: darker_blue,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          type,
          style: TextStyle(
            color: white_op,
          ),
        ),
      ],
    ),
  );
}

void pickeFile(String type, chats, chatDocId, currentUser, friendName) async {
  late File pickedAttachment;
  if (type == 'Document') {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: true);
    if (result != null) {
      for (int i = 0; i < result.files.length; i++) {
        UploadFile(File(result.files[i].path.toString()), type,
            result.files[i].name, chats, chatDocId, currentUser, friendName);
      }
    }
  } else if (type == 'Camera') {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
  } else if (type == 'Gallery') {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.media, allowMultiple: true);
    if (result != null) {
      File file = File(result.files.first.path.toString());
      if (result != null) {
        for (int i = 0; i < result.files.length; i++) {
          UploadFile(File(result.files[i].path.toString()), type,
              result.files[i].name, chats, chatDocId, currentUser, friendName);
        }
      }
    }
  } else if (type == 'Audio') {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: true);
    if (result != null) {
      File file = File(result.files.first.path.toString());
      if (result != null) {
        for (int i = 0; i < result.files.length; i++) {
          UploadFile(File(result.files[i].path.toString()), type,
              result.files[i].name, chats, chatDocId, currentUser, friendName);
        }
      }
    }
  } else if (type == 'Location') {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: true);
    if (result != null) {
      File file = File(result.files.first.path.toString());
      String fileName = result.files.first.name;
      // Upload file
      await FirebaseStorage.instance
          .ref()
          .child('$currentUser/Location/$fileName')
          .putFile(file);
    }
  } else if (type == 'Contact') {
    final FullContact contact = await FlutterContactPicker.pickFullContact();
    if (contact != null) {
      sendMassage(type, chats, chatDocId, currentUser, friendName, contact);
    }
  }
}
