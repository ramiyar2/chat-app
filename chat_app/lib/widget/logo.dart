import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.color,
  }) : super(key: key);

  final color;

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
            color: color,
          ),
        )
      ],
    );
  }
}
