// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pokebet_login/global.dart';

class MeowthLogo extends StatelessWidget {
  const MeowthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: setHeight(130),
          width: setWidth(164),
          // color: Colors.pink,
          child: Image.asset(
            'assets/imgs/meowth_${Global.isDarkTheme ? "dark" : "light"}.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16),
        Container(
          // color: Colors.pink,
          child: Text(
            "PokeBet",
            style: TextStyle(
              color: Global.highlightTextColor,
              fontSize: 24,
              fontFamily: 'Chakra',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
