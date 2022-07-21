import 'dart:io';

import 'package:chat_app/data/color.dart';
import 'package:chat_app/data/theme.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CompleteSigin extends StatefulWidget {
  late String name;

  CompleteSigin(String name, {Key? key}) : super(key: key) {
    this.name = name;
  }

  @override
  State<CompleteSigin> createState() => _CompleteSiginState();
}

class _CompleteSiginState extends State<CompleteSigin> {
  final ImagePicker _picker = ImagePicker();
  File? pakedImage;
  final _auth = FirebaseAuth.instance;

  ImageProvider _userImage = AssetImage('assets/img/user.png');
  FechImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          pakedImage = File(croppedFile.path);
          _userImage = FileImage(pakedImage!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        image: DecorationImage(
                          image: _userImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: FechImage,
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 2, color: green)),
                        child: Icon(
                          Icons.camera_alt,
                          size: 25,
                          color: darker_blue,
                        ),
                      ),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () async {
                      print(
                          'object---------------------------------------------');
                      final _ref = FirebaseStorage.instance
                          .ref()
                          .child('users_images')
                          .child(_auth.currentUser!.uid + '.jpg');
                      if (pakedImage != null) {
                        await _ref.putFile(pakedImage!);
                      }
                      final profileUrl = await _ref.getDownloadURL();
                      _auth.currentUser
                          ?.updateDisplayName(widget.name.toString());
                      _auth.currentUser?.updatePhotoURL(profileUrl.toString());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text('sbumit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
