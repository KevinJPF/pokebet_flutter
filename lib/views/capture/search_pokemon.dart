// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/models/pokemon_data.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class SearchPokemon extends StatefulWidget {
  final bool filtrarResultados;
  final int shinyChances;
  final bool canBeLegendary;
  final int maxStats;
  final List<String>? commonTypes;
  final List<String>? rareTypes;
  final int pokemonMinimumQuantity;
  final int pokemonMaximumQuantity;
  final int evolutionChainLimit;
  const SearchPokemon({
    super.key,
    this.filtrarResultados = false,
    this.shinyChances = 100,
    this.canBeLegendary = false,
    this.maxStats = 999,
    this.commonTypes,
    this.rareTypes,
    this.pokemonMinimumQuantity = 0,
    this.pokemonMaximumQuantity = 1017,
    this.evolutionChainLimit = 3,
  });

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {
  bool canPop = false;
  bool searchingPokemon = false;
  UserPokemon? foundPokemon;
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
                        TopBar(
                            showBackButton: true,
                            pageTitle: 'Procurar Pokemon'),
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
                          Spacer(),
                          if (foundPokemon != null) ...[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.6,
                              width: MediaQuery.of(context).size.width * 0.6,
                              color: Colors.transparent,
                              child: Image.network(
                                foundPokemon!.officialImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SimpleText(
                              '${foundPokemon!.name}${foundPokemon!.shiny == 1 ? ' ⋆' : ''}',
                              fontColor: Global.pokebetColors.highlightColor,
                              fontSize: 28,
                            ),
                            SizedBox(height: setHeight(16)),
                            Spacer(),
                            CustomButton(
                              buttonText: 'Capturar Pokemon',
                              onPressed: () async {
                                await UserPokemon.InsertPokemonDatabase(
                                    foundPokemon!);
                                Global.userPokemons.add(foundPokemon!);
                                print('Capturou um pokemon');
                                foundPokemon = null;
                                searchingPokemon = false;
                                setState(() {});
                              },
                            ),
                          ],
                          if (searchingPokemon && foundPokemon == null) ...[
                            Container(
                              // color: Colors.pink,
                                margin: EdgeInsets.all(setHeight(32)),
                                child: Image.asset('assets/imgs/search.gif')),
                                SimpleText('Procurando um Pokemon pelas redondezas...'),
                                Spacer(),
                          ] else if (foundPokemon == null) ...[
                            SimpleText(
                                'Pokemons estão por perto, procure-os...')
                          ],
                          SizedBox(height: setHeight(16)),
                          CustomButton(
                            buttonText: 'Procurar Pokemon',
                            onPressed: () async {
                              searchingPokemon = true;
                              foundPokemon = null;
                              setState(() {});
                              foundPokemon = await FilterPokemon(
                                filtrarResultados: widget.filtrarResultados,
                                shinyChances: widget.shinyChances,
                                canBeLegendary: widget.canBeLegendary,
                                maxStats: widget.maxStats,
                                commonTypes: widget.commonTypes,
                                rareTypes: widget.rareTypes,
                                pokemonMinimumQuantity:
                                    widget.pokemonMinimumQuantity,
                                pokemonMaximumQuantity:
                                    widget.pokemonMaximumQuantity,
                                evolutionChainLimit: widget.evolutionChainLimit,
                              );
                              print('Gerou um pokemon');
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
