// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// FirebaseAuth _auth = FirebaseAuth.instance;
//
// CollectionReference<Map<String, dynamic>> users =
//     FirebaseFirestore.instance.collection('users');
// CreateUser(pakedImage, name) async {
//   final ref = FirebaseStorage.instance
//       .ref()
//       .child('users_images')
//       .child(_auth.currentUser!.uid + '.jpg');
//   if (pakedImage != null) {
//     await ref.putFile(pakedImage);
//   }
//   final profileUrl = await ref.getDownloadURL();
//   _auth.currentUser?.updateDisplayName(name);
//   _auth.currentUser?.updatePhotoURL(profileUrl.toString());
//
//   users
//       .where('uid', isEqualTo: _auth.currentUser?.uid)
//       .limit(1)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     if (querySnapshot.docs.isEmpty) {
//       users.add({
//         'userName': name,
//         'phoneNumber': _auth.currentUser!.phoneNumber,
//         'status': 'avalibly',
//         'profileImageUrl': profileUrl.toString(),
//         'uid': _auth.currentUser!.uid
//       });
//     }
//   }).catchError((e) => print(e));
// }
