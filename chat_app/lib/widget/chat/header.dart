import 'package:chat_app/screens/other/audio_call.dart';
import 'package:chat_app/screens/other/video_call.dart';
import 'package:flutter/material.dart';
import '../../data/color.dart';
import '../../data/icons.dart';

Container header(context, friendName, String frindProfile, String callUid) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: 100,
    decoration: BoxDecoration(
        color: darker_blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [BoxShadow(color: green, spreadRadius: 1)]),
    child: ListTile(
      title: Text(friendName.toString()),
      leading: SizedBox(
        width: 110,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.keyboard_backspace_rounded),
              color: Colors.white,
              iconSize: 28,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      frindProfile,
                    ),
                  )),
            ),
          ],
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoCallScreen(callUid),
                  ),
                );
              },
              icon: Image.network(
                video,
                width: 28,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AudioCallScreen(callUid)));
              },
              icon: Image.network(
                call,
                width: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
