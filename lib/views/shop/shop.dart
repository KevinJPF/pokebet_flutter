// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/views/profile/player_profile.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_popup.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/icon_container.dart';
import 'package:PokeBet/widgets/menu_bar.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
                      // TopBar
                      Column(
                        children: [
                          TopBar(showBackButton: false, pageTitle: 'Loja'),
                        ],
                      ),
                      // Content
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: setHeight(80),
                          bottom: setHeight(40),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.abc,
                              iconPNGName: 'pokebola',
                              mainText: 'Pokebola',
                              showRightIcon: true,
                              rightText: '200',
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.abc,
                              iconPNGName: 'grandebola',
                              mainText: 'Grande Bola',
                              showRightIcon: true,
                              rightText: '1200',
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.abc,
                              iconPNGName: 'ultrabola',
                              mainText: 'Ultra Bola',
                              showRightIcon: true,
                              rightText: '2000',
                            ),
                            SizedBox(height: setHeight(8)),
                            IconContainer(
                              icon: Icons.abc,
                              iconPNGName: 'masterbola',
                              mainText: 'Bola Mestra',
                              showRightIcon: true,
                              rightText: '10000',
                            ),
                            Spacer(),
                            if (Global.userItems.isEmpty) ...[
                              CustomButton(
                                buttonText: 'Pegar Itens Iniciais',
                                onPressed: () {
                                  UserItem pokeball = UserItem(
                                    name: 'Pokebola',
                                    quantity: 10,
                                    userId: Global.userData!.id!,
                                  );
                                  UserItem.InsertItemDatabase(pokeball);

                                  UserItem greatball = UserItem(
                                    name: 'Grande Bola',
                                    quantity: 5,
                                    userId: Global.userData!.id!,
                                  );
                                  UserItem.InsertItemDatabase(greatball);

                                  UserItem ultraball = UserItem(
                                    name: 'Master Bola',
                                    quantity: 1,
                                    userId: Global.userData!.id!,
                                  );
                                  UserItem.InsertItemDatabase(ultraball);

                                  Global.userItems.addAll(
                                    [
                                      pokeball,
                                      greatball,
                                      ultraball,
                                    ],
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomPopup(
                                      popupTitle: "Itens Iniciais Recebidos",
                                      popupMessage:
                                          "Parabéns, você acaba de receber os seus itens iniciais para sua jornada! Acesse sua bolsa para ver o que recebeu.",
                                      firstButtonText: 'Fechar',
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Show Pokecoins in top left screen
                      Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: setWidth(48), top: setHeight(26)),
                                    padding:
                                        EdgeInsets.only(left: setWidth(26), top: setHeight(0.8)),
                                    height: setHeight(30),
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.8),
                                          spreadRadius: 0,
                                          blurRadius: 6,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: SimpleText(
                                      Global.userData!.money.toString(),
                                      fontColor:
                                          Global.pokebetColors.simpleTextWhiteBackgroundColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: setWidth(32), top: setHeight(26)),
                                    height: setHeight(42),
                                    width: setWidth(42),
                                    // color: Colors.blue,
                                    child:
                                        Image.asset('assets/imgs/pokecoin.png'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BottomMenuBar(selectedMenu: 'shop'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
