import 'dart:io';

import 'package:chat_app/screens/home_screen.dart';
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
  FechImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
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
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(FirebaseAuth.instance.currentUser!.uid.toString()),
              pakedImage == null
                  ? Container()
                  : Image.file(
                      pakedImage!,
                    ),
              TextButton(
                onPressed: FechImage,
                child: Text('add photo'),
              ),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser
                        ?.updateDisplayName(widget.name.toString());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('sbumit'))
            ],
          ),
        ),
      ),
    );
  }
}
