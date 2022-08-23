import 'package:flutter/material.dart';
import 'style.dart';

class ImageMsg extends StatelessWidget {
  var data;
  var currentUser;
  ImageMsg({required this.data, required this.currentUser, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: getBorderRadios(data['uid'], currentUser),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(data['msg']),
        ),
      ),
      child: null,
    );
  }
}
