import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Verify extends StatefulWidget {
  var green;
  var dark_green;
  var dark_blue;
  var darker_blue;

  Verify(c1, c2, c3, c4, {Key? key}) : super(key: key) {
    green = c1;
    dark_green = c2;
    dark_blue = c3;
    darker_blue = c4;
  }

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  var number = 'null';

  late String strInputVerfiyText;

  late String rightInputVerfiyText = '123456';
  late String _verificationCode;
  var _verifyConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 230,
                ),
                Logo(green: widget.green),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Enter the code that we sent to \n' + number,
                  style: TextStyle(fontSize: 13, color: widget.green),
                ),
                const SizedBox(
                  height: 40,
                ),
                Pinput(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  length: 6,
                  controller: _verifyConroller,
                  onSubmitted: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          print('Home Page');
                        }
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  defaultPinTheme: MyPinTheme(widget.dark_blue),
                  focusedPinTheme: MyPinTheme(widget.green),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Edit the number',
                  style: TextStyle(fontSize: 13, color: widget.green),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Resend code',
                  style: TextStyle(fontSize: 13, color: widget.green),
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
      ),
    );
  }

  PinTheme MyPinTheme(Color color) {
    return PinTheme(
      width: 40,
      height: 55,
      textStyle: TextStyle(
        color: widget.green,
        fontSize: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2.0),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }

  Center ForwardButtom(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 66,
        height: 66,
        decoration: BoxDecoration(
          color: widget.green,
          borderRadius: BorderRadius.circular(33),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_forward_rounded,
            color: widget.darker_blue,
            size: 33,
          ),
          onPressed: () {
            strInputVerfiyText = _verifyConroller.text;
            print(strInputVerfiyText);
          },
        ),
      ),
    );
  }

  _VerfiyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+17835106866',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print('Home Page');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String _verficationId, int? resendToken) {
          setState(() {
            _verificationCode = _verficationId;
          });
        },
        codeAutoRetrievalTimeout: (String _verficationId) {
          setState(() {
            _verificationCode = _verficationId;
          });
        },
        timeout: Duration(minutes: 20));
  }
}

// logo
class Logo extends StatelessWidget {
  const Logo({
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
