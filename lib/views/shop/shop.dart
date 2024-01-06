// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_popup.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
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
                        TopBar(showBackButton: false, pageTitle: 'Loja'),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                        top: setHeight(80),
                        bottom: setHeight(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: setWidth(32)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Image.network(
                                'https://www.hxchector.com/wp-content/uploads/pokemon-lets-go-pikachu-eevee-pokemart1.jpg',
                                fit: BoxFit
                                    .cover, // Certifique-se de ajustar o BoxFit conforme necessário
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.symmetric(horizontal: setWidth(32)),
                            child: SimpleText(
                                'Loja em construção!\nVolte em breve para aproveitar nossos itens!'),
                          ),
                          Spacer(),
                          if (Global.userItems.isEmpty)
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
