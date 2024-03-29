import 'package:pokebet/views/profile/player_profile.dart';
import 'package:pokebet/widgets/icon_container.dart';
import 'package:pokebet/widgets/menu_bar.dart';
import 'package:pokebet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';

class Tournaments extends StatefulWidget {
  const Tournaments({super.key});

  @override
  State<Tournaments> createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {
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
                          TopBar(showBackButton: false, pageTitle: 'Torneios'),
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
                               IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Iniciante',
                                iconPNGName: 'beginner',
                                assetRightIconName: 'lvl',
                                rightText: '1',
                                onClick: () async {
                                  
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Amador',
                                iconPNGName: 'amateur',
                                assetRightIconName: 'lvl',
                                rightText: '5',
                                onClick: () async {
                                 
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Experiente',
                                iconPNGName: 'experient',
                                assetRightIconName: 'lvl',
                                rightText: '10',
                                onClick: () async {
                                  
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Veterano',
                                iconPNGName: 'veteran',
                                assetRightIconName: 'lvl',
                                rightText: '15',
                                onClick: () async {
                                  
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Profissional',
                                iconPNGName: 'professional',
                                assetRightIconName: 'lvl',
                                rightText: '20',
                                onClick: () async {
                                  
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              IconContainer(
                                icon: Icons.remove_circle_outlined,
                                mainText: 'Mestre',
                                iconPNGName: 'master',
                                assetRightIconName: 'lvl',
                                rightText: '30',
                                onClick: () async {
                                  
                                },
                              ),
                              SizedBox(height: setHeight(8)),
                              // Container(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: setWidth(32)),
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.circular(35),
                              //     child: Image.network(
                              //       'https://www.videogameschronicle.com/files/2022/11/2022111909505800_c.jpg',
                              //       fit: BoxFit
                              //           .cover, // Certifique-se de ajustar o BoxFit conforme necessário
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   alignment: Alignment.centerLeft,
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: setWidth(32)),
                              //   child: SimpleText(
                              //       'Torneios em construção!\nVolte em breve para aproveitar nossos eventos!'),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BottomMenuBar(selectedMenu: 'tournaments'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
