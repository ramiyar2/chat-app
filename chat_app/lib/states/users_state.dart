import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';


// Include generated file
part 'users_state.g.dart';

// This is the class used by rest of your codebase
class UsersState = _UsersState with _$UsersState;

// The store-class
abstract class _UsersState with Store {
  @observable
  Map<String, dynamic> users = ObservableMap();

  final ImagePicker _picker = ImagePicker();
  @observable
  File? pakedImage;

  final _auth = FirebaseAuth.instance;
  var profileUrl;
  CollectionReference<Map<String, dynamic>> _usersCollection =
  FirebaseFirestore.instance.collection('users');

  @action
  void initUseresListeners(){
    FirebaseFirestore.instance.collection('users').snapshots().listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String , dynamic>  data = doc.data() as Map<String , dynamic>;
        users[data['uid']] = {
          'userName' : data['userName'],
          'status' : data['status'],
          'phoneNumber' : data['phoneNumber'],
          'profileImageUrl' : data['profileImageUrl'],
        };
      });
    });
  }
  void takeImageFromGallary() async{
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
            pakedImage = File(croppedFile.path);
            _uploadImage();
        }
      }
  }
  void takeImageFromCamera() async{
    final XFile? image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
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
        pakedImage = File(croppedFile.path);
        _uploadImage();
      }
    }
  }
  void _uploadImage (){
    if(pakedImage==null) return ;
    else{
      final profileImageRef = FirebaseStorage.instance.ref().child('${_auth.currentUser?.uid}/photos/profile.jpg');
      profileImageRef.putFile(pakedImage!).snapshotEvents.listen(
              (taskSnapshot) {
                switch (taskSnapshot.state) {
                  case TaskState.running:
                    break;
                  case TaskState.paused:
                    break;
                  case TaskState.success:
                    profileImageRef.getDownloadURL().then((value) {
                      profileUrl =value;
                    });
                    break;
                  case TaskState.canceled:
                    break;
                  case TaskState.error:
                    break;
                }
              }
      );
    }
  }
  void createOrUpdateUserInFirestore(name){
  FirebaseAuth.instance.currentUser?.updateDisplayName(name.toString());
  FirebaseAuth.instance.currentUser?.updatePhotoURL(profileUrl.toString());
  var docId;
  this._usersCollection
      .where('uid', isEqualTo: _auth.currentUser?.uid)
      .limit(1)
      .get()
      .then((QuerySnapshot querySnapshot) {
    // add user info
    if (querySnapshot.docs.isEmpty) {
      _usersCollection.add({
        'userName': name.toString(),
        'phoneNumber': _auth.currentUser!.phoneNumber,
        'status': 'avalibly',
        'profileImageUrl': profileUrl.toString(),
        'uid': _auth.currentUser!.uid
      });
    }else{
      docId = querySnapshot.docs.first.id;
    }
    // update user info
    if(docId != null){
      this._usersCollection.doc(docId).update({
        'userName': name.toString(),
        'phoneNumber': _auth.currentUser!.phoneNumber,
        'status': 'avalibly',
        'profileImageUrl': profileUrl.toString(),
        'uid': _auth.currentUser!.uid
      });
    }
  }).catchError((e) => print(e));
      }
}