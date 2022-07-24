import 'package:flutter/material.dart';
import '../../data/color.dart';
import '../../data/icons.dart';

Container header(context, friendName) {
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
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "http://placeimg.com/640/480/any",
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
              onPressed: () {},
              icon: Image.network(
                video,
                width: 28,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
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
