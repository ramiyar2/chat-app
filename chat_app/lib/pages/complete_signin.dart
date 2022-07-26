import 'package:chat_app/data/color.dart';
import 'package:chat_app/data/theme.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/states/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CompleteSigin extends StatefulWidget {
  late String name;

  CompleteSigin(String name, {Key? key}) : super(key: key) {
    this.name = name;
  }

  @override
  State<CompleteSigin> createState() => _CompleteSiginState();
}

class _CompleteSiginState extends State<CompleteSigin> {
  ImageProvider imageProvider = AssetImage('assets/img/user.png');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Observer(
                      builder: (BuildContext context) {
                        return Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                            image: DecorationImage(
                              image: usersState.pakedImage != null
                                  ? FileImage(usersState.pakedImage!)
                                  : imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () => Alert(context),
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 2, color: green)),
                        child: Icon(
                          Icons.camera_alt,
                          size: 25,
                          color: darker_blue,
                        ),
                      ),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      usersState.createOrUpdateUserInFirestore(widget.name);
                      // CreateUser(pakedImage, widget.name);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text('sbumit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> Alert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Center(
          child: Container(
            width: 500,
            height: 190,
            child: AlertDialog(
              title: Text('Take profile picture From!'),
              content: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        usersState.takeImageFromCamera();
                        Navigator.pop(context);
                      },
                      child: Text('Camera'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        usersState.takeImageFromGallary();
                        Navigator.pop(context);
                      },
                      child: Text('Gallary'),
                    )
                  ],
                )
              ]),
            ),
          ),
        );
      });
}
