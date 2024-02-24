import 'package:pokebet/models/database_models.dart';
import 'package:pokebet/widgets/custom_button.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:pokebet/widgets/icon_container.dart';
import 'package:pokebet/widgets/pokemon_type.dart';
import 'package:pokebet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';

class PokemonProfile extends StatefulWidget {
  final UserPokemon pokemonData;
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
  UserPokemon? _pokemonData;

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
      backgroundColor: Global.pokebetColors.backgroundColor,
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
                              _pokemonData!.officialImage,
                              fit: BoxFit.contain,
                              // width: MediaQuery.of(context).size.width * 0.6,
                            ),
                          ),
                          SimpleText(
                            '#${_pokemonData!.pokedexNumber} - ${_pokemonData!.nickname}${_pokemonData!.shiny == 1 ? ' ⋆' : ''}',
                            fontColor: Global.pokebetColors.highlightColor,
                            fontSize: 28,
                          ),
                          SizedBox(height: setHeight(8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TypeIcon(_pokemonData!.firstType),
                              if (_pokemonData!.secondType != null) ...[
                                SizedBox(width: setWidth(16)),
                                TypeIcon(_pokemonData!.secondType!),
                              ]
                            ],
                          ),
                          SizedBox(height: setHeight(16)),
                          IconContainer(
                            icon: Icons.volcano_rounded,
                            mainText: 'Ataque',
                            svgName: 'Ataque',
                            secondaryText: _pokemonData!.attack.round().toString(),
                          ),
                          SizedBox(height: setHeight(8)),
                          IconContainer(
                            icon: Icons.shield_sharp,
                            mainText: 'Defesa',
                            svgName: 'Defesa',
                            secondaryText:
                                _pokemonData!.defense.round().toString(),
                          ),
                          SizedBox(height: setHeight(8)),
                          IconContainer(
                            icon: Icons.run_circle_rounded,
                            mainText: 'Velocidade',
                            svgName: 'Velocidade',
                            secondaryText: _pokemonData!.speed.round().toString(),
                          ),
                          SizedBox(height: setHeight(8)),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: setWidth(32)),
                            child: SimpleText(
                                'Total: ${(_pokemonData!.speed + _pokemonData!.defense + _pokemonData!.attack).round()}'),
                          ),
                          Spacer(),
                          SimpleText(
                              'Capturado em: ${_pokemonData!.capturedAt.toString().substring(0, 16)}'),
                          if (widget.buttonText != null) ...[
                            SizedBox(height: setHeight(16)),
                            CustomButton(
                              buttonText: widget.buttonText ?? '',
                              onPressed: widget.buttonOnPressed ??
                                  () {
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
