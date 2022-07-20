import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompleteSigin extends StatelessWidget {
  late String name;
  CompleteSigin(String name, {Key? key}) : super(key: key) {
    this.name = name;
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
              TextField(),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser
                        ?.updateDisplayName(name.toString());
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
