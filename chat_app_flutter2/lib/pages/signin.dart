import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signin extends StatelessWidget {
  var green;
  var dark_green;
  var dark_blue;
  var darker_blue;
  signin(c1, c2, c3, c4, {Key? key}) : super(key: key) {
    green = c1;
    dark_green = c2;
    dark_blue = c3;
    darker_blue = c4;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: double.infinity,
            height: double.infinity,
            color: dark_blue,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // logo
                  SizedBox(
                    height: 230,
                  ),
                  logo(green: green),
                  SizedBox(
                    height: 40,
                  ),

                  // input
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: green,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                    ),
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: green,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Phone number",
                    style: TextStyle(
                      fontSize: 16,
                      color: green,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      prefix: Text('+964   '),
                    ),
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class logo extends StatelessWidget {
  const logo({
    Key? key,
    required this.green,
  }) : super(key: key);

  final green;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/img/myLogo.png',
          width: 100,
          height: 100,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Chat',
          style: TextStyle(
            fontSize: 31.5,
            color: green,
          ),
        )
      ],
    );
  }
}
