import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../data/color.dart';
import '../widget/logo.dart';

class Verify extends StatefulWidget {
  late String number;
  Verify(number) {
    this.number = number;
  }
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  late String strInputVerfiyText;
  bool showSpiner = false;
  late String _verificationCode;
  var _verifyConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpiner,
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
                  Logo(color: green),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Enter the code that we sent to \n' + widget.number,
                    style: TextStyle(fontSize: 13, color: green),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 6,
                    controller: _verifyConroller,
                    onSubmitted: (pin) => _CheckCode(pin),
                    defaultPinTheme: MyPinTheme(dark_blue),
                    focusedPinTheme: MyPinTheme(green),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Edit the number',
                    style: TextStyle(fontSize: 13, color: green),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Resend code',
                    style: TextStyle(fontSize: 13, color: green),
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
      ),
    );
  }

  PinTheme MyPinTheme(Color color) {
    return PinTheme(
      width: 40,
      height: 55,
      textStyle: TextStyle(
        color: green,
        fontSize: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2.0),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }

  _CheckCode(String pin) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        }
        setState(() {
          showSpiner = false;
        });
      });
    } catch (e) {
      setState(() {
        showSpiner = false;
      });
      FocusScope.of(context).unfocus();
      print('wrong');
    }
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
              showSpiner = true;
            });
            strInputVerfiyText = _verifyConroller.text;
            _CheckCode(strInputVerfiyText);
          },
        ),
      ),
    );
  }

  _VerfiyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  (route) => false);
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
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    print('hi ${widget.number}  -----------------------------------');
    _VerfiyPhone();
  }
}
