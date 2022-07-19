// ignore_for_file: prefer_const_constructors

import 'package:chat_app/main.dart';
import 'package:chat_app/pages/verify.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../data/color.dart';
import '../widget/logo.dart';

class Signin extends StatefulWidget {
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var inputName = TextEditingController();
  var inputNumber = TextEditingController();
  String strInputNumber = ' ';
  String countryCode = '964';
  String strInputName = ' ';
  bool NumberIsEmpty = true;
  bool NameIsEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: double.infinity,
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
                  Logo(color: green),
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
                    controller: inputName,
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
                    controller: inputNumber,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: green,
                    ),
                    dropdownTextStyle: TextStyle(
                      fontSize: 13.5,
                      color: green,
                    ),
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      color: green,
                    ),
                    pickerDialogStyle: PickerDialogStyle(
                      backgroundColor: dark_blue,
                      countryNameStyle: TextStyle(color: Colors.white),
                      countryCodeStyle: TextStyle(color: Colors.white),
                    ),
                    initialCountryCode: 'IQ',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (value) {
                      setState(() {
                        countryCode = value.dialCode;
                      });
                      print(countryCode);
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //ForwardButtom
                  ForwardButtom(context),
                ],
              ),
            ),
          ),
        ));
  }

  Center ForwardButtom(BuildContext context) {
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
          onPressed: () {
            setState(() {
              strInputNumber = '+$countryCode${inputNumber.text}';
            });
            strInputNumber.isEmpty
                ? NumberIsEmpty = true
                : NumberIsEmpty = false;
            if (NumberIsEmpty) {
              ErrorAlert(context);
            } else {
              Alert(context);
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> Alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Center(
            child: Container(
              width: 500,
              height: 290,
              child: AlertDialog(
                title: Text('Are you sure !'),
                content: Column(children: [
                  Text('Are you sure that the number ' +
                      strInputNumber +
                      ' is your number'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Edit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Verify(strInputNumber)));
                        },
                        child: Text('Yes'),
                      )
                    ],
                  )
                ]),
              ),
            ),
          );
        });
  }

  Future<dynamic> ErrorAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Center(
            child: Container(
              width: 500,
              height: 240,
              child: AlertDialog(
                backgroundColor: dark_blue,
                title: Text('Erorr !'),
                content: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('please enter right number '),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Edit'),
                      )
                    ]),
              ),
            ),
          );
        });
  }
}
