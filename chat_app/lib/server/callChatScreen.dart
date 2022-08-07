import 'package:flutter/material.dart';
import '../screens/pages/chat_page.dart';

void callChatScreen(BuildContext ctx, name, uid,profile) {
  Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (BuildContext context) => ChatPage(
                friendName: name,
                friendUid: uid,
                frindProfile: profile,
              )));
}
