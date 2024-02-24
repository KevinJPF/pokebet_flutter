import 'package:pokebet/widgets/custom_texts.dart';
import 'package:pokebet/widgets/icon_container.dart';
import 'package:pokebet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';

class PlayerStats extends StatefulWidget {
  const PlayerStats({super.key});

  @override
  State<PlayerStats> createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return Scaffold(
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
                        TopBar(showBackButton: true, pageTitle: 'Estatísticas'),
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
                              // padding: EdgeInsets.all(setWidth(7.5)),
                              width: setWidth(200),
                              height: setWidth(200),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Global.pokebetColors.highlightColor,
                                    width: setWidth(3)),
                                color: Global.pokebetColors
                                    .backgroundColor, // Cor de fundo
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
                              mainText:
                                  '${Global.userData!.experience}/${(Global.userData!.level + 1) * 100}',
                              secondaryText: 'Experiência de Treinador',
                              iconPNGName: 'exp',
                              onClick: () {},
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.backpack_rounded,
                              mainText: '${Global.userPokemons.length}',
                              secondaryText: 'Pokemons Capturados',
                              iconPNGName: 'pokeball',
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.auto_graph_rounded,
                              mainText:
                                  '${Global.userData!.pokebetsWon}/${Global.userData!.pokebetsParticipated}',
                              secondaryText: 'Pokebets Vencidos',
                              iconPNGName: 'versus',
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
                              mainText:
                                  '${Global.userData!.tournamentsWon}/${Global.userData!.tournamentsParticipated}',
                              secondaryText: 'Torneios Vencidos',
                              iconPNGName: 'trophy',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // BottomMenuBar(),
            ],
          ),
        ),
      ),
    );
  }
}
