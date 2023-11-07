import 'package:flutter/material.dart';

class MeowthLogo extends StatelessWidget {
  const MeowthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 60),
          height: 144,
          width: 164,
          child: Image.asset(
            'assets/imgs/meowth.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: const Text(
            "PokeBet",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 112, 1),
              fontSize: 24,
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
