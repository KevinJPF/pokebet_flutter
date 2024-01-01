// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/icon_container.dart';
import 'package:PokeBet/widgets/menu_bar.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:PokeBet/widgets/meowth_logo.dart';

class PlayerProfile extends StatefulWidget {
  const PlayerProfile({super.key});

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return Scaffold(
      backgroundColor: Global.backgroundColor,
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
                        TopBar(showBackButton: false, pageTitle: 'Perfil'),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 80, bottom: 40),
                      // color: Colors.pink,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // padding: EdgeInsets.all(setWidth(7.5)),
                              width: setWidth(200),
                              height: setWidth(200),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Global.highlightColor,
                                    width: setWidth(3)),
                                color: Global.backgroundColor, // Cor de fundo
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/imgs/profile.jpg',
                                  fit: BoxFit.cover,
                                  // color: Global.frameColor,
                                ),
                              ),
                            ),
                            SizedBox(height: setHeight(16)),
                            SimpleText(
                              Global.userName,
                              fontColor: Global.highlightColor,
                              fontSize: setFontSize(32),
                            ),
                            SimpleText(
                              'Treinador Nv. ${Global.userLevel}',
                            ),
                            SizedBox(height: setHeight(16)),
                            IconContainer(
                              icon: Icons.remove_circle_outlined,
                              mainText: 'Pokemons',
                              svgName: 'Pokeball',
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.backpack_rounded,
                              mainText: 'Itens',
                              svgName: 'Backpack',
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.auto_graph_rounded,
                              mainText: 'Estatísticas',
                              svgName: 'Player_Stats',
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.settings,
                              mainText: 'Configurações',
                              svgName: 'Config',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomMenuBar(),
            ],
          ),
        ),
      ),
    );
  }
}
