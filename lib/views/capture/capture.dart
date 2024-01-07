// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/models/pokemon_data.dart';
import 'package:PokeBet/views/profile/player_profile.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
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
                        ],
                      ),
                      CustomButton(buttonText: 'Procurar Pokemon', onPressed: () {}),
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
