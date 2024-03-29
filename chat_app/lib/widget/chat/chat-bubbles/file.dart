import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../data/color.dart';
import 'style.dart';

class FileMsg extends StatelessWidget {
  var data;
  var currentUser;
  FileMsg({required this.data, required this.currentUser, Key? key})
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
            children: [
              const Icon(Icons.document_scanner_rounded, color: Colors.white),
              const SizedBox(
                width: 10,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.4),
                child: Text(
                  data['file'],
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
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
