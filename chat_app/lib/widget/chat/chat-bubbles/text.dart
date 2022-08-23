import 'package:flutter/material.dart';
import '../../../data/color.dart';
import 'style.dart';

class TextMsg extends StatelessWidget {
  var data;
  var currentUser;
  TextMsg({required this.data, required this.currentUser, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          getAligment(data['uid'], isColumn: true, currentUser: currentUser),
      children: [
        Text(
          data['msg'],
          style: TextStyle(
              color:
                  getColor(data['uid'], isText: true, currentUser: currentUser),
              fontSize: 10,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '10:10 PM',
          style: TextStyle(color: white_op, fontSize: 10),
        ),
      ],
    );
  }
}
