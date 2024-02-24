import 'package:pokebet/models/database_models.dart';
import 'package:pokebet/views/capture/capture_field.dart';
import 'package:pokebet/views/profile/player_profile.dart';
import 'package:pokebet/widgets/icon_container.dart';
import 'package:pokebet/widgets/menu_bar.dart';
import 'package:pokebet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';

class Capture extends StatefulWidget {
  const Capture({super.key});

  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  String camposVerdesDescription =
      'Uma vasta planície habitada principalmente por Pokémon do tipo voador e normal, enquanto tipos grama e inseto também podem ser encontrados ocasionalmente.';
  String florestaAbetoDescription =
      'Uma densa floresta de árvores de abeto onde predominam Pokémon do tipo grama, inseto e normal. Ocasionalmente, podem ser avistados Pokémon do tipo voador e terrestre.';
  String cavernaObscuraDescription =
      'Uma caverna sombria utilizada como passagem entre rotas e cidades, habitada principalmente por Pokémon do tipo pedra, terrestre e noturno. Alguns raros Pokémon elétricos e de fogo também podem ser encontrados.';
  String lagoDePescaDescription =
      'Um lago frequentemente visitado por pescadores e treinadores, sendo lar de Pokémon do tipo água. Em ocasiões mais raras, podem ser avistados Pokémon do tipo voador e normal.';
  String cavernaCongeladaDescription =
      'Uma caverna remota, permanentemente congelada e lar de Pokémon do tipo gelo. Tipos noturno e fantasma são avistados ocasionalmente.';
  String cidadeAbandonadaDescription =
      'Antiga vítima de um desastre natural, a cidade é predominantemente habitada por Pokémon dos tipos fantasma e venenoso, enquanto aparições raras de Pokémon psíquico adicionam um toque de mistério.';
  String vulcaoDescription =
      'A base de um vulcão que esteve ativo há poucos anos, agora habitada por Pokémon do tipo fogo, com raros representantes do tipo dragão, evidenciando a energia ardente que ainda emana das profundezas.';
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
                    children: [
                      Background(hasLogo: false),
                      TopBar(showBackButton: false, pageTitle: 'Capturar'),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: setHeight(80),
                          bottom: setHeight(40),
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Campos Verdes',
                                assetImageName: 'plains',
                                assetRightIconName: 'lvl',
                                rightText: '1',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Campos Verdes',
                                        fieldDescription:
                                            camposVerdesDescription,
                                        fieldImageName: 'plains',
                                        commonTypes: ['flying', 'normal'],
                                        rareTypes: ['grass', 'bug'],
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
                                assetRightIconName: 'lvl',
                                rightText: '2',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Floresta Abeto',
                                        fieldDescription:
                                            florestaAbetoDescription,
                                        fieldImageName: 'forest',
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
                                mainText: 'Lago de Pesca',
                                assetImageName: 'lake',
                                assetRightIconName: 'lvl',
                                rightText: '3',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Lago de Pesca',
                                        fieldDescription:
                                            lagoDePescaDescription,
                                        fieldImageName: 'lake',
                                        commonTypes: ['water'],
                                        rareTypes: ['flying', 'normal'],
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
                                assetRightIconName: 'lvl',
                                rightText: '5',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Caverna Obscura',
                                        fieldDescription:
                                            cavernaObscuraDescription,
                                        fieldImageName: 'cavern',
                                        commonTypes: ['rock', 'ground', 'dark'],
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
                                mainText: 'Deserto Escaldante',
                                assetImageName: 'desert',
                                assetRightIconName: 'lvl',
                                rightText: '7',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Deserto Escaldante',
                                        fieldDescription:
                                            lagoDePescaDescription,
                                        fieldImageName: 'desert',
                                        commonTypes: ['ground'],
                                        rareTypes: ['rock', 'fire'],
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Floresta Mítica',
                                assetImageName: 'mystic_forest',
                                assetRightIconName: 'lvl',
                                rightText: '8',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Floresta Mítica',
                                        fieldDescription:
                                            lagoDePescaDescription,
                                        fieldImageName: 'mystic_forest',
                                        commonTypes: [
                                          'fairy',
                                          'psychic',
                                          'grass'
                                        ],
                                        rareTypes: ['normal', 'water'],
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Caverna Congelada',
                                assetImageName: 'snow_cave',
                                assetRightIconName: 'lvl',
                                rightText: '10',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Caverna Congelada',
                                        fieldDescription:
                                            cavernaCongeladaDescription,
                                        fieldImageName: 'snow_cave',
                                        commonTypes: ['ice'],
                                        rareTypes: ['dark', 'ghost'],
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Cidade Abandonada',
                                assetImageName: 'city',
                                assetRightIconName: 'lvl',
                                rightText: '12',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Cidade Abandonada',
                                        fieldDescription:
                                            cidadeAbandonadaDescription,
                                        fieldImageName: 'city',
                                        commonTypes: ['ghost', 'poison'],
                                        rareTypes: ['psychic'],
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Montanha Rochosa',
                                assetImageName: 'rock_mountain',
                                assetRightIconName: 'lvl',
                                rightText: '15',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Montanha Rochosa',
                                        fieldDescription:
                                            lagoDePescaDescription,
                                        fieldImageName: 'rock_mountain',
                                        commonTypes: [
                                          'fighting',
                                          'rock',
                                          'flying',
                                        ],
                                        rareTypes: ['steel', 'ground'],
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Pico da Montanha',
                                assetImageName: 'mountain_peak',
                                assetRightIconName: 'lvl',
                                rightText: '18',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Pico da Montanha',
                                        fieldDescription:
                                            lagoDePescaDescription,
                                        fieldImageName: 'mountain_peak',
                                        commonTypes: ['steel', 'flying'],
                                        rareTypes: ['rock', 'ground'],
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Pé do Vulcão',
                                assetImageName: 'volcano',
                                assetRightIconName: 'lvl',
                                rightText: '22',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Pé do Vulcão',
                                        fieldDescription: vulcaoDescription,
                                        fieldImageName: 'volcano',
                                        commonTypes: ['fire'],
                                        rareTypes: ['dragon'],
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Portal Lendário',
                                assetImageName: 'legendary_portal',
                                assetRightIconName: 'lvl',
                                rightText: '25',
                                onClick: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CaptureField(
                                        fieldName: 'Portal Lendário',
                                        fieldDescription: vulcaoDescription,
                                        fieldImageName: 'legendary_portal',
                                        canBeLegendary: true,
                                        commonTypes: ['fire', 'water', 'grass'],
                                        rareTypes: ['dragon'],
                                      ),
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
                BottomMenuBar(selectedMenu: 'capture'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
