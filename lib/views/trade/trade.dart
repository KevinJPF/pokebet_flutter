// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:pokebet/views/profile/player_profile.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:pokebet/widgets/menu_bar.dart';
import 'package:pokebet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';

class Trade extends StatefulWidget {
  const Trade({super.key});

  @override
  State<Trade> createState() => _TradeState();
}

class _TradeState extends State<Trade> {
  bool canPop = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        setState(() {
          canPop = true;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PlayerProfile(),
            ),
          );
        });
      },
      child: Scaffold(
        backgroundColor: Global.pokebetColors.backgroundColor,
        body: SafeArea(
          child: Container(
            height: availableHeight,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Background(hasLogo: false),
                      Column(
                        children: [
                          TopBar(showBackButton: false, pageTitle: 'Trocar'),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: setHeight(80),
                          bottom: setHeight(40),
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: setWidth(32)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Image.network(
                                    'https://staticg.sportskeeda.com/editor/2023/10/927c3-16975163222739.png',
                                    fit: BoxFit
                                        .cover, // Certifique-se de ajustar o BoxFit conforme necessário
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: setWidth(32)),
                                child: SimpleText(
                                    'Serviço de trocas em construção!\nVolte em breve para trocar pokemons com seus amigos!'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BottomMenuBar(selectedMenu: 'trade'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
