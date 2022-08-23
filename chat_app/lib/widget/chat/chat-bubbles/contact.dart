import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../data/color.dart';
import 'style.dart';

class ContactMsg extends StatelessWidget {
  var data;
  var currentUser;
  ContactMsg({required this.data, required this.currentUser, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          getAligment(data['uid'], isColumn: true, currentUser: currentUser),
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: const AssetImage('assets/img/user.png'),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(getName(data)),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '10:10 PM',
          style: TextStyle(color: white_op, fontSize: 10),
        ),
      ],
    );
  }
}

String getName(data) {
  String fName = data['Contact']['firstName'] ?? '';
  String mName = data['Contact']['middleName'] ?? '';
  String lName = data['Contact']['lastName'] ?? '';
  print("$fName $mName $lName        +56489465");
  return "$fName $mName $lName";
}
