// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/database/db_connection.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_popup.dart';
import 'package:PokeBet/widgets/meowth_logo.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                        TopBar(showBackButton: true, pageTitle: 'Configurações'),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 80, bottom: 40),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: setHeight(16)),
                            MeowthLogo(
                              onTap: () {
                                setState(() {});
                              },
                            ),
                            SizedBox(height: setHeight(16)),
                            CustomButton(buttonText: 'Resetar Banco de Dados', onPressed: () {
                              DatabaseConnection().deleteAllTableData('users');
                              DatabaseConnection().deleteAllTableData('players');
                              DatabaseConnection().deleteAllTableData('user_pokemons');
                              DatabaseConnection().deleteAllTableData('user_items');

                                showDialog(
                                  context: context,
                                  builder: (context) => CustomPopup(
                                    popupTitle: "Banco de Dados resetado com sucesso",
                                    popupMessage:
                                        "Você será redirecionado para a tela de login.",
                                    firstButtonText: 'Fechar',
                                    onPressedFirstButton: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                            })
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
