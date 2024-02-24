import 'package:pokebet/global.dart';
import 'package:pokebet/views/capture/capture.dart';
import 'package:pokebet/views/profile/player_profile.dart';
import 'package:pokebet/views/shop/shop.dart';
import 'package:pokebet/views/tournament/tournament.dart';
import 'package:pokebet/views/trade/trade.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenuBar extends StatelessWidget {
  final String selectedMenu;
  const BottomMenuBar({super.key, required this.selectedMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: setHeight(16)),
      padding: EdgeInsets.only(
          left: setWidth(16), right: setWidth(16), bottom: setHeight(0)),
      // color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MontaItem(
              itemName: 'Loja',
              svgName: 'Shop',
              highlight: selectedMenu == 'shop',
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
              highlight: selectedMenu == 'capture',
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
              highlight: selectedMenu == 'tournaments',
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
              highlight: selectedMenu == 'trade',
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
              highlight: selectedMenu == 'profile',
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
  final bool highlight;
  const MontaItem({
    super.key,
    required this.itemName,
    required this.svgName,
    required this.onTap,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: highlight ? 16 : 0),
        // color: Colors.blue,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              // color: Colors.pink,
              child: Container(
                height: setHeight(50),
                width: setWidth(60),
                child: SvgPicture.asset(
                  'assets/svgs/$svgName.svg',
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                      highlight
                          ? Global.pokebetColors.highlightColor
                          : Global.pokebetColors.simpleTextColor,
                      BlendMode.srcIn),
                ),
              ),
            ),
            SimpleText(
              itemName,
              fontColor: highlight
                  ? Global.pokebetColors.highlightColor
                  : Global.pokebetColors.simpleTextColor,
            )
          ],
        ),
      ),
    );
  }
}
