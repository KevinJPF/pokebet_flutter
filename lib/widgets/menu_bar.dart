import 'package:PokeBet/global.dart';
import 'package:PokeBet/views/capture.dart';
import 'package:PokeBet/views/player_profile.dart';
import 'package:PokeBet/views/shop.dart';
import 'package:PokeBet/views/tournament.dart';
import 'package:PokeBet/views/trade.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: setHeight(16)),
      padding: EdgeInsets.only(left: setWidth(16),right: setWidth(16),bottom: setHeight(16)),
      // color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MontaItem(
              itemName: 'Loja',
              svgName: 'Shop',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Shop(),
                  ),
                );
              }),
          MontaItem(
              itemName: 'Capturar',
              svgName: 'Capture',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Capture(),
                  ),
                );
              }),
          MontaItem(
              itemName: 'Torneios',
              svgName: 'Tournaments',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Tournaments(),
                  ),
                );
              }),
          MontaItem(
              itemName: 'Trocar',
              svgName: 'Trade',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Trade(),
                  ),
                );
              }),
          MontaItem(
              itemName: 'Perfil',
              svgName: 'Profile',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => PlayerProfile(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class MontaItem extends StatelessWidget {
  final String itemName;
  final String svgName;
  final VoidCallback onTap;
  const MontaItem({
    super.key,
    required this.itemName,
    required this.svgName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // color: Colors.blue,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              // color: Colors.pink,
              child: SizedBox(
                height: setHeight(50),
                width: setWidth(60),
                child: SvgPicture.asset(
                  'assets/svgs/$svgName.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SimpleText(itemName)
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
