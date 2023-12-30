import 'package:flutter/material.dart';
import 'package:pokebet_login/global.dart';

class Background extends StatelessWidget {
  final bool hasLogo;
  const Background({super.key, required this.hasLogo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: hasLogo ? 150 : 16, bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(
        color: Global.frameColor,
        borderRadius:
            BorderRadius.circular(30), // Valor do border radius.
      ),
    );
  }
}
