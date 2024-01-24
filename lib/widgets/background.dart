import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';

class Background extends StatelessWidget {
  final bool hasLogo;
  const Background({super.key, required this.hasLogo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: hasLogo ? setHeight(150) : setHeight(16), bottom: setHeight(16), right: setWidth(16), left: setWidth(16)),
      decoration: BoxDecoration(
        color: Global.pokebetColors.frameColor,
        borderRadius:
            BorderRadius.circular(30), // Valor do border radius.
      ),
    );
  }
}
