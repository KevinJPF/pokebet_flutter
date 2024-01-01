// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/models/pokemon_data.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/icon_container.dart';
import 'package:PokeBet/widgets/pokemon_type.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class PokemonProfile extends StatefulWidget {
  final PokemonData pokemonData;
  final bool? showBackButton;
  final String? buttonText;
  final VoidCallback? buttonOnPressed;

  const PokemonProfile({
    super.key,
    required this.pokemonData,
    this.showBackButton,
    this.buttonText,
    this.buttonOnPressed,
  });

  @override
  State<PokemonProfile> createState() => _PokemonProfileState();
}

class _PokemonProfileState extends State<PokemonProfile> {
  var _pokemonData = PokemonData();

  @override
  void initState() {
    super.initState();

    _pokemonData = widget.pokemonData;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return Scaffold(
      backgroundColor: Global.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          TopBar(showBackButton: widget.showBackButton ?? true),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.5,
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: Colors.transparent,
                            child: Image.network(
                              _pokemonData.spriteUrl,
                              fit: BoxFit.contain,
                              // width: MediaQuery.of(context).size.width * 0.6,
                            ),
                          ),
                          SimpleText(
                            '#${_pokemonData.pokemonID} - ${_pokemonData.name}${_pokemonData.isShiny ? ' ⋆' : ''}',
                            fontColor: Global.highlightColor,
                            fontSize: 28,
                          ),
                          SizedBox(height: setHeight(16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TypeIcon(_pokemonData.firstType),
                              if (_pokemonData.secondType != '') ...[
                                SizedBox(width: setWidth(16)),
                                TypeIcon(_pokemonData.secondType),
                              ]
                            ],
                          ),
                          SizedBox(height: setHeight(16)),
                          IconContainer(
                            icon: Icons.volcano_rounded,
                            mainText: 'Ataque',
                            svgName: 'Ataque',
                            secondaryText: _pokemonData.stats.attack.toString(),
                          ),
                          SizedBox(height: setHeight(8)),
                          IconContainer(
                            icon: Icons.shield_sharp,
                            mainText: 'Defesa',
                            svgName: 'Defesa',
                            secondaryText:
                                _pokemonData.stats.defense.toString(),
                          ),
                          SizedBox(height: setHeight(8)),
                          IconContainer(
                            icon: Icons.run_circle_rounded,
                            mainText: 'Velocidade',
                            svgName: 'Velocidade',
                            secondaryText: _pokemonData.stats.speed.toString(),
                          ),
                          SizedBox(height: setHeight(16)),
                          Spacer(),
                          SimpleText(
                              'Capturado em: ${_pokemonData.captureDate.toString().substring(0, 16)}'),
                          if (widget.buttonText != null) ...[
                            SizedBox(height: setHeight(16)),
                            CustomButton(
                              buttonText: widget.buttonText ?? '',
                              onPressed: widget.buttonOnPressed ?? () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          SizedBox(
                            height: setHeight(32),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
