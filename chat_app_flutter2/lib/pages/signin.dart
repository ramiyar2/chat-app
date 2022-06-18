// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  const SizedBox(
                    height: 230,
                  ),
                  logo(green: green),
                  const SizedBox(
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
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                    ),
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: green,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Phone number",
                    style: TextStyle(
                      fontSize: 16,
                      color: green,
                    ),
                  ),
                  IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: green,
                    ),
                    initialCountryCode: 'IQ',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ForwardButtom(green: green, darker_blue: darker_blue)
                ],
              ),
            ),
          ),
        ));
  }
}

class ForwardButtom extends StatelessWidget {
  const ForwardButtom({
    Key? key,
    required this.green,
    required this.darker_blue,
  }) : super(key: key);

  final green;
  final darker_blue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 66,
        height: 66,
        decoration: BoxDecoration(
          color: green,
          borderRadius: BorderRadius.circular(33),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_forward_rounded,
            color: darker_blue,
            size: 33,
          ),
          onPressed: () {},
        ),
      ),
    );
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
        const SizedBox(
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
