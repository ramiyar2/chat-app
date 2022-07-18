import 'package:flutter/material.dart';

class Verify extends StatelessWidget {
  var green;
  var dark_green;
  var dark_blue;
  var darker_blue;
  var number = 'null';
  List<String> strInputVerfiyText = ['', '', '', '', '', ''];
  List<String> rightInputVerfiyText = ['1', '2', '3', '4', '5', '6'];
  List _textEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  Verify(c1, c2, c3, c4, {Key? key}) : super(key: key) {
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
                Logo(green: green),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Enter the code that we sent to \n' + number,
                  style: TextStyle(fontSize: 13, color: green),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < _textEditingController.length; i++)
                      VerfiyTextField(i, context),
                  ],
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
    );
  }

  // Text field
  SizedBox VerfiyTextField(int i, ctx) {
    int index = i;
    return SizedBox(
      width: 40,
      height: 55,
      child: TextField(
        controller: _textEditingController[index],
        decoration: verfiyInputDecoration(),
        keyboardType: TextInputType.phone,
        maxLength: 1,
        textAlign: TextAlign.end,
        onChanged: (value) {
          if (value.length == 1 && i != _textEditingController.length)
            FocusScope.of(ctx).nextFocus();
          else
            FocusScope.of(ctx).unfocus();
        },
        style: TextStyle(
          color: green,
        ),
      ),
    );
  }

  InputDecoration verfiyInputDecoration() {
    return InputDecoration(
      counterText: '',
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: dark_blue, width: 2.0),
          borderRadius: BorderRadius.circular(7)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: green, width: 2.0),
          borderRadius: BorderRadius.circular(7)),
    );
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
            for (int i = 0; i <= 5; i++) {
              strInputVerfiyText[i] = _textEditingController[i].text;
            }

            if (strInputVerfiyText
                .any((item) => rightInputVerfiyText.contains(item))) {
              print('ok');
            } else {
              print(strInputVerfiyText);
              print(rightInputVerfiyText);
            }
          },
        ),
      ),
    );
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
