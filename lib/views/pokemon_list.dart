// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:PokeBet/models/pokemon_data.dart';
import 'package:PokeBet/views/pokemon_profile.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/icon_container.dart';
import 'package:PokeBet/widgets/menu_bar.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class PokemonList extends StatefulWidget {
  final List<PokemonData> listOfPokemon;
  const PokemonList({super.key, required this.listOfPokemon});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  List<PokemonData> _listOfPokemon = [];

  @override
  void initState() {
    super.initState();
    _listOfPokemon = widget.listOfPokemon;
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
                            showBackButton: true, pageTitle: 'Meus Pokemons'),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 80, bottom: 40),
                      child: ListView.builder(
                        itemCount: _listOfPokemon.length,
                        itemBuilder: (context, index) {
                          PokemonData pokemon = _listOfPokemon[index];

                          return Container(
                            margin:
                                EdgeInsets.symmetric(vertical: setHeight(4)),
                            child: IconContainer(
                              icon: Icons.pets,
                              spriteIndex: pokemon.pokemonID,
                              mainText: '#${pokemon!.pokemonID} - ${pokemon!.name}${pokemon!.isShiny ? ' ⋆' : ''}',
                              secondaryText: '${pokemon.firstType}${pokemon.secondType != '' ? "/${pokemon.secondType}" : ""}',
                              onClick: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PokemonProfile(
                                      pokemonData: pokemon,
                                      showBackButton: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                  buttonText: 'New Pokemon',
                  onPressed: () async {
                    var newPokemon =
                        await GetPokemonData(Random().nextInt(1017) + 1);
                    Global.userPokemons.add(newPokemon!);
                    print('Gerou um pokemon');
                    setState(() {});
                  }),
              // BottomMenuBar(),
            ],
          ),
        ),
      ),
    );
  }
}
