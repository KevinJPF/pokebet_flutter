// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/views/profile/player_stats.dart';
import 'package:PokeBet/views/profile/multiple_list.dart';
import 'package:PokeBet/views/profile/settings.dart';
import 'package:PokeBet/widgets/custom_popup.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/icon_container.dart';
import 'package:PokeBet/widgets/menu_bar.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:flutter/services.dart';

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

    return PopScope(
      canPop: Global.canPopLogout,
      onPopInvoked: (didPop) {
        if (Global.canPopLogout == false) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              popupTitle: 'Sair',
              popupMessage: 'Tem certeza que deseja sair do PokeBet?',
              firstButtonText: 'Voltar',
              secondButtonText: 'Sair',
              onPressedSecondButton: () {
                Navigator.of(context).pop();
                setState(() {
                  Global.canPopLogout = true;
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  SystemNavigator.pop();
                });
              },
            ),
          );
        }
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
                          TopBar(showBackButton: false, pageTitle: 'Perfil'),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: setHeight(80),
                          bottom: setHeight(40),
                        ),
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
                                      color:
                                          Global.pokebetColors.highlightColor,
                                      width: setWidth(3)),
                                  color: Global.pokebetColors
                                      .backgroundColor, // Cor de fundo
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/imgs/profile.jpg',
                                    fit: BoxFit.cover,
                                    // color: Global.pokebetColors.frameColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: setHeight(16)),
                              SimpleText(
                                Global.userData!.name,
                                fontColor: Global.pokebetColors.highlightColor,
                                fontSize: setFontSize(32),
                              ),
                              SimpleText(
                                'Treinador Nv. ${Global.userData!.level}',
                              ),
                              SizedBox(height: setHeight(16)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Pokemons',
                                svgName: 'Pokeball',
                                onClick: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MultipleList(
                                          listName: 'Meus Pokemons',
                                          listOfPokemon: Global.userPokemons),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.backpack_rounded,
                                mainText: 'Itens',
                                svgName: 'Backpack',
                                onClick: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MultipleList(
                                          listName: 'Meus Itens',
                                          listOfItems: Global.userItems),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.auto_graph_rounded,
                                mainText: 'Estatísticas',
                                svgName: 'Player_Stats',
                                onClick: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PlayerStats(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.settings,
                                mainText: 'Configurações',
                                svgName: 'Config',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Settings(),
                                    ),
                                  );
                                  setState(() {});
                                },
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
      ),
    );
  }
}
