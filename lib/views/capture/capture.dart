// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:PokeBet/models/pokemon_data.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/menu_bar.dart';
import 'package:PokeBet/widgets/pokemon_type.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:PokeBet/widgets/meowth_logo.dart';

class Capture extends StatefulWidget {
  const Capture({super.key});

  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  PokemonData? foundPokemon = null;
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
                        TopBar(showBackButton: false, pageTitle: 'Capturar'),
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
                            CustomButton(
                              buttonText: 'Procurar Pokemon',
                              onPressed: () async {
                                foundPokemon = null;
                                setState(() {});
                                foundPokemon = await GetPokemonData(
                                    Random().nextInt(1017) + 1);
                                print('Gerou um pokemon');
                                setState(() {});
                              },
                            ),
                            if (foundPokemon != null) ...[
                              Container(
                                height: MediaQuery.of(context).size.width * 0.6,
                                width: MediaQuery.of(context).size.width * 0.6,
                                color: Colors.transparent,
                                child: Image.network(
                                  foundPokemon!.spriteUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SimpleText(
                                '${foundPokemon!.name}${foundPokemon!.isShiny ? ' ⋆' : ''}',
                                fontColor: Global.pokebetColors.highlightColor,
                                fontSize: 28,
                              ),
                              SizedBox(height: setHeight(16)),
                              CustomButton(
                                buttonText: 'Capturar Pokemon',
                                onPressed: () async {
                                  Global.userPokemons.add(foundPokemon!);
                                  print('Capturou um pokemon');
                                  foundPokemon = null;
                                  setState(() {});
                                },
                              ),
                            ] else ...[
                              Container(margin: EdgeInsets.all(setHeight(32)), child: CircularProgressIndicator()),
                            ],
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
