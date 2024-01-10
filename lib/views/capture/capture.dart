// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/views/capture/capture_field.dart';
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
  String camposVerdesDescription = 'Uma vasta planície habitada principalmente por Pokémon do tipo voador e normal, enquanto tipos grama e inseto também podem ser encontrados ocasionalmente.';
  String florestaAbetoDescription = 'Uma densa floresta de árvores de abeto onde predominam Pokémon do tipo grama, inseto e normal. Ocasionalmente, podem ser avistados Pokémon do tipo voador e terrestre.';
  String cavernaObscuraDescription = 'Uma caverna sombria utilizada como passagem entre rotas e cidades, habitada principalmente por Pokémon do tipo pedra, terrestre e noturno. Alguns raros Pokémon elétricos e de fogo também podem ser encontrados.';
  String lagoDePescaDescription = 'Um lago frequentemente visitado por pescadores e treinadores, sendo lar de Pokémon do tipo água. Em ocasiões mais raras, podem ser avistados Pokémon do tipo voador e normal.';
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
                                  builder: (context) => CaptureField(
                                    fieldName: 'Campos Verdes',
                                    fieldDescription: camposVerdesDescription,
                                    fieldImageName: 'campos_verdes',
                                    commonTypes: ['flying', 'normal'],
                                    rareTypes: ['grass','bug'],
                                  ),
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
                                  builder: (context) => CaptureField(
                                    fieldName: 'Floresta Abeto',
                                    fieldDescription: florestaAbetoDescription,
                                    fieldImageName: 'floresta_abeto',
                                    commonTypes: ['grass', 'bug', 'normal'],
                                    rareTypes: ['flying', 'ground'],
                                  ),
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
                                  builder: (context) => CaptureField(
                                    fieldName: 'Caverna Obscura',
                                    fieldDescription: cavernaObscuraDescription,
                                    fieldImageName: 'caverna_obscura',
                                    commonTypes: ['rock', 'ground','dark'],
                                    rareTypes: ['electric', 'fire'],
                                  ),
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
                                  builder: (context) => CaptureField(
                                    fieldName: 'Lago de Pesca',
                                    fieldDescription: lagoDePescaDescription,
                                    fieldImageName: 'lago_de_pesca',
                                    commonTypes: ['water'],
                                    rareTypes: ['flying', 'normal'],
                                  ),
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
