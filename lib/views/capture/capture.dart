// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/views/capture/search_pokemon.dart';
import 'package:PokeBet/views/profile/player_profile.dart';
import 'package:PokeBet/widgets/icon_container.dart';
import 'package:PokeBet/widgets/menu_bar.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class Capture extends StatefulWidget {
  const Capture({super.key});

  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  bool canPop = false;
  bool searchingPokemon = false;
  UserPokemon? foundPokemon;
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
                          TopBar(showBackButton: false, pageTitle: 'Capturar'),
                          IconContainer(
                            icon: Icons.remove_circle_outlined,
                            mainText: 'Campos Verdes',
                            assetImageName: 'plains',
                            onClick: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchPokemon(),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                          SizedBox(height: setHeight(8)),
                          IconContainer(
                            icon: Icons.remove_circle_outlined,
                            mainText: 'Floresta Abeto',
                            assetImageName: 'forest',
                            onClick: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchPokemon(),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                          SizedBox(height: setHeight(8)),
                          IconContainer(
                            icon: Icons.remove_circle_outlined,
                            mainText: 'Caverna Obscura',
                            assetImageName: 'cavern',
                            onClick: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchPokemon(),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                          SizedBox(height: setHeight(8)),
                          IconContainer(
                            icon: Icons.remove_circle_outlined,
                            mainText: 'Lago de Pesca',
                            assetImageName: 'lake',
                            onClick: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchPokemon(),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                          SizedBox(height: setHeight(8)),
                        ],
                      ),
                    ],
                  ),
                ),
                BottomMenuBar(selectedMenu: 'capture'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
